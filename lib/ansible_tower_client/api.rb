require 'pp'

module AnsibleTowerClient
  class Api < Connection
    include Logging

    DEFAULT_ERROR_MSG = "An unknown error was returned from the provider".freeze

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
      JSON.parse(get("me/").body).fetch_path("results", 0, "username")
    end

    def activity_stream
      Collection.new(self, activity_stream_class)
    end

    def ad_hoc_commands
      Collection.new(self, ad_hoc_command_class)
    end

    def credentials
      Collection.new(self, credential_class)
    end

    def credential_types
      Collection.new(self, credential_type_class)
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

    def job_events
      Collection.new(self, job_event_class)
    end

    def job_plays
      Collection.new(self, job_play_class)
    end

    def job_templates
      Collection.new(self, job_template_class)
    end

    def organizations
      Collection.new(self, organization_class)
    end

    def projects
      Collection.new(self, project_class)
    end

    def project_updates
      Collection.new(self, project_update_class)
    end

    def schedules
      Collection.new(self, schedule_class)
    end

    def system_jobs
      Collection.new(self, system_job_class)
    end

    def system_job_templates
      Collection.new(self, system_job_template_class)
    end

    def workflow_job_nodes
      Collection.new(self, workflow_job_node_class)
    end

    def workflow_jobs
      Collection.new(self, workflow_job_class)
    end

    def workflow_job_templates
      Collection.new(self, workflow_job_template_class)
    end

    def workflow_job_template_nodes
      Collection.new(self, workflow_job_template_node_class)
    end

    def method_missing(method_name, *args, &block)
      require 'faraday'
      if instance.respond_to?(method_name)
        path = build_path_to_resource(args.shift)
        args.unshift(path)
        logger.debug { "#{self.class.name} Sending <#{method_name}> with <#{args.inspect}>" }
        instance.send(method_name, *args, &block).tap do |response|
          logger.debug { "#{self.class.name} Response:\n#{log_from_response(response)}" }
        end
      else
        super
      end
    rescue Faraday::ConnectionFailed => err
      raise AnsibleTowerClient::ConnectionError, err
    rescue Faraday::SSLError => err
      raise AnsibleTowerClient::SSLError, err
    rescue Faraday::ClientError => err
      raise AnsibleTowerClient::ConnectionError, err
    end

    def respond_to_missing?(method, _include_private = false)
      instance.respond_to?(method)
    end

    # Object class accessors patched for the appropriate version of the API

    def activity_stream_class
      @activity_stream_class ||= AnsibleTowerClient::ActivityStream
    end

    def ad_hoc_command_class
      @ad_hoc_command_class ||= AnsibleTowerClient::AdHocCommand
    end

    def credential_class
      @credential_class ||= AnsibleTowerClient::Credential
    end

    def credential_type_class
      @credential_type_class ||= AnsibleTowerClient::CredentialType
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

    def job_event_class
      @job_event_class ||= AnsibleTowerClient::JobEvent
    end

    def job_play_class
      @job_play_class ||= AnsibleTowerClient::JobPlay
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

    def organization_class
      @organization_class ||= AnsibleTowerClient::Organization
    end

    def project_class
      @project_class ||= AnsibleTowerClient::Project
    end

    def project_update_class
      @project_update_class ||= AnsibleTowerClient::ProjectUpdate
    end

    def schedule_class
      @schedule_class ||= AnsibleTowerClient::Schedule
    end

    def system_job_class
      @system_job_class ||= AnsibleTowerClient::SystemJob
    end

    def system_job_template_class
      @system_job_template_class ||= AnsibleTowerClient::SystemJobTemplate
    end

    def workflow_job_class
      @workflow_job_class ||= AnsibleTowerClient::WorkflowJob
    end

    def workflow_job_node_class
      @workflow_job_node_class ||= AnsibleTowerClient::WorkflowJobNode
    end

    def workflow_job_template_class
      @workflow_job_template_class ||= AnsibleTowerClient::WorkflowJobTemplate
    end

    def workflow_job_template_node_class
      @workflow_job_template_node_class ||= AnsibleTowerClient::WorkflowJobTemplateNode
    end

    private

    def build_path_to_resource(original)
      return original unless %r{\/?api\/v1\/(.*)} =~ original
      return original if instance.url_prefix.path == "/"
      File.join(instance.url_prefix.path, Regexp.last_match[1])
    end
  end
end
