module AnsibleTowerClient
  class MockApi
    class Response
      attr_reader :body
      def initialize(body)
        @body = body
      end
    end

    def initialize(version = nil)
      @version = version
    end

    def get(path, get_options = nil)
      suffix = path.split("api/v1/").last
      case suffix
      when "ad_hoc_commands"
        wrap_response(AdHocCommand.response)
      when "config"
        wrap_response(Config.response(@version))
      when "credentials"
        wrap_response(Credential.response)
      when "groups"
        wrap_response(Group.response)
      when "hosts"
        wrap_response(Host.response)
      when "inventories"
        wrap_response(Inventory.response)
      when "inventory_sources"
        wrap_response(InventorySource.response)
      when "jobs"
        wrap_response(Job.response)
      when "job_templates"
        wrap_response(JobTemplate.response)
      when "workflow_jobs"
        wrap_response(WorkflowJob.response)
      when "workflow_job_templates"
        wrap_response(WorkflowJobTemplate.response)
      when "organizations"
        wrap_response(Organization.response)
      when "projects"
        wrap_response(Project.response)
      when "me"
        wrap_response(Me.response)
      end
    end

    def wrap_response(data)
      AnsibleTowerClient::MockApi::Response.new(data)
    end
  end
end
