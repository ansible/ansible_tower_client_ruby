require 'pp'

module AnsibleTowerClient
  class Api < Connection
    include Logging

    attr_reader :instance
    def initialize(connection)
      @instance = connection
    end

    def config
      JSON.parse(get("config").body)
    end

    def version
      @version ||= config["version"]
    end

    def verify_credentials
      JSON.parse(get("me").body).fetch_path("results", 0, "username")
    end

    def ad_hoc_commands
      Collection.new(self, ad_hoc_command_class)
    end

    def groups
      Collection.new(self, group_class)
    end

    def hosts
      Collection.new(self, host_class)
    end

    def inventories
      Collection.new(self, inventory_class)
    end

    def inventory_sources
      Collection.new(self, inventory_source_class)
    end

    def inventory_updates
      Collection.new(self, inventory_update_class)
    end

    def jobs
      Collection.new(self, job_class)
    end

    def job_templates
      Collection.new(self, job_template_class)
    end

    def method_missing(method_name, *args, &block)
      if instance.respond_to?(method_name)
        logger.debug { "#{self.class.name} Sending <#{method_name}> with <#{args.inspect}>" }
        instance.send(method_name, *args, &block).tap do |response|
          logger.debug { "#{self.class.name} Response:\n#{JSON.parse(response.body).pretty_inspect}" }
        end
      else
        super
      end
    rescue Faraday::ConnectionFailed, Faraday::SSLError => err
      raise
    rescue Faraday::ClientError => err
      response = err.response
      logger.debug { "#{self.class.name} #{err.class.name} #{response.pretty_inspect}" }
      message   = JSON.parse(response[:body])['detail'] rescue nil
      message ||= "An unknown error was returned from the provider"
      logger.error("#{self.class.name} #{err.class.name} #{message}")
      raise AnsibleTowerClient::ConnectionError, message
    end

    def respond_to_missing?(method, _include_private = false)
      instance.respond_to?(method)
    end

    # Object class accessors patched for the appropriate version of the API

    def ad_hoc_command_class
      @ad_hoc_command_class ||= AnsibleTowerClient::AdHocCommand
    end

    def group_class
      @group_class ||= AnsibleTowerClient::Group
    end

    def host_class
      @host_class ||= AnsibleTowerClient::Host
    end

    def inventory_class
      @inventory_class ||= AnsibleTowerClient::Inventory
    end

    def inventory_source_class
      @inventory_source_class ||= AnsibleTowerClient::InventorySource
    end

    def inventory_update_class
      @inventory_update_class ||= AnsibleTowerClient::InventoryUpdate
    end

    def job_class
      @job_class ||= AnsibleTowerClient::Job
    end

    def job_template_class
      @job_template_class ||= begin
        if Gem::Version.new(version).between?(Gem::Version.new(2), Gem::Version.new(3))
          AnsibleTowerClient::JobTemplateV2
        else
          AnsibleTowerClient::JobTemplate
        end
      end
    end
  end
end
