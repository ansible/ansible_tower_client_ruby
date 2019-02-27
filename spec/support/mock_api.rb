module AnsibleTowerClient
  class MockApi
    class Response
      attr_reader :body, :url

      def initialize(body, url = nil)
        @body = body
        @url  = url
      end
    end

    RESPONSES = {
      'ad_hoc_commands'             => 'AdHocCommand',
      'config'                      => 'Config',
      'credentials'                 => 'Credential',
      'groups'                      => 'Group',
      'hosts'                       => 'Host',
      'inventories'                 => 'Inventory',
      'inventory_sources'           => 'InventorySource',
      'jobs'                        => 'Job',
      'job_templates'               => 'JobTemplate',
      'organizations'               => 'Organization',
      'projects'                    => 'Project',
      'me'                          => 'Me',
      'workflow_jobs'               => 'WorkflowJob',
      'workflow_job_nodes'          => 'WorkflowJobNode',
      'workflow_job_template_nodes' => 'WorkflowJobTemplateNode',
      'workflow_job_templates'      => 'WorkflowJobTemplate',
    }.freeze

    def initialize(version = nil)
      @version = version
    end

    def get(path, get_options = nil)
      suffix = path.split("api/v1/").last
      suffix = suffix[0..-2] if suffix.end_with?('/')
      response_module = RESPONSES.fetch(suffix)

      args = []
      args << @version if response_module == 'Config'

      response_class = AnsibleTowerClient::MockApi.const_get(response_module)
      response_data  = response_class.response(*args)
      AnsibleTowerClient::MockApi::Response.new(response_data, path)
    end
  end
end
