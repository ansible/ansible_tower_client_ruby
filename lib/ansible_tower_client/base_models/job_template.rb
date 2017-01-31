module AnsibleTowerClient
  class JobTemplate < BaseModel
    def launch(options = {})
      launch_url = "#{url}launch/"
      response   = api.post(launch_url, options).body
      job        = JSON.parse(response)
      api.jobs.find(job['job'])
    end

    def survey_spec
      spec_url = related['survey_spec']
      return nil unless spec_url
      api.get(spec_url).body
    rescue AnsibleTowerClient::UnlicensedFeatureError
    end

    def survey_spec_hash
      survey_spec.nil? ? {} : hashify(:survey_spec)
    end

    def extra_vars_hash
      extra_vars.empty? ? {} : hashify(:extra_vars)
    end
  end
end
