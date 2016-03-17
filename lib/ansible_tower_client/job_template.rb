module AnsibleTowerClient
  class JobTemplate < BaseModel
    def launch(vars = {})
      launch_url = "#{url}launch/"
      pay_load = Data.validate!(vars)
      resp = api.post(launch_url, pay_load).body
      job = JSON.parse(resp)
      api.jobs.find(job['job'])
    end

    def survey_spec
      spec_url = related['survey_spec']
      return nil unless spec_url
      api.get(spec_url).body
    end

    def self.endpoint
      "job_templates".freeze
    end
  end
end
