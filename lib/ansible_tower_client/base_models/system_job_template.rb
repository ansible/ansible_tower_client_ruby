module AnsibleTowerClient
  class SystemJobTemplate < BaseModel
    def launch(extra_vars)
      response = JSON.parse(api.post("#{url}launch/", "extra_vars" => extra_vars).body)
      api.system_jobs.find(response["system_job"])
    end

    def schedules
      Collection.new(api).find_all_by_url(related["schedules"])
    end
  end
end
