module AnsibleTowerClient
  class WorkflowJobTemplate < JobTemplate
    def self.endpoint
      'workflow_job_templates'.freeze
    end

    def launch(options = {})
      launch_url = "#{url}launch/"
      response   = api.post(launch_url, options).body
      job        = JSON.parse(response)
      api.workflow_jobs.find(job['workflow_job'])
    end

    def workflow_nodes
      Collection.new(api).find_all_by_url(related['workflow_nodes'])
    end

    def override_raw_attributes
      { :organization => :organization_id }
    end
  end
end
