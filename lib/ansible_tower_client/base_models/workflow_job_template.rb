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

    # def survey_spec
    #   spec_url = related['survey_spec']
    #   return nil unless spec_url
    #   api.get(spec_url).body
    # rescue AnsibleTowerClient::UnlicensedFeatureError
    # end
    #
    # def survey_spec_hash
    #   survey_spec.nil? ? {} : hashify(:survey_spec)
    # end
    #
    # def extra_vars_hash
    #   extra_vars.empty? ? {} : hashify(:extra_vars)
    # end
    #
    def override_raw_attributes
      { :organization => :organization_id }
    end
  end
end
