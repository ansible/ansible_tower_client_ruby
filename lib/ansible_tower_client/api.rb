module AnsibleTowerClient
  class Api < Connection
    attr_reader :instance
    def initialize(connection)
      @instance = connection
    end

    def hosts
      Collection.new(self, Host)
    end

    def groups
      Collection.new(self, Group)
    end

    def inventories
      Collection.new(self, Inventory)
    end

    def inventory_sources
      Collection.new(self, InventorySource)
    end

    def inventory_updates
      Collection.new(self, InventoryUpdate)
    end

    def job_templates
      Collection.new(self, job_template_class)
    end

    def ad_hoc_commands
      Collection.new(self, AdHocCommand)
    end

    def jobs
      Collection.new(self, Job)
    end

    def method_missing(method_name, *args, &block)
      instance.respond_to?(method_name) ? instance.send(method_name, *args, &block) : super
    rescue Faraday::ConnectionFailed, Faraday::SSLError => err
      raise
    rescue Faraday::ClientError => err
      message = JSON.parse(err.message)['detail'] rescue nil
      message ||= "An unknown error was returned from the provider"
      raise AnsibleTowerClient::ConnectionError, message
    end

    def respond_to_missing?(method, _include_private = false)
      instance.respond_to?(method)
    end

    # Object class accessors patched for the appropriate version of the API

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
