module AnsibleTowerClient
  class Job < BaseModel
    def extra_vars_hash
      extra_vars.empty? ? {} : hashify(:extra_vars)
    end

    def job_events(options = nil)
      Collection.new(api, api.job_event_class).find_all_by_url(related["job_events"], options)
    end

    def stdout(format = 'txt')
      out_url = related['stdout']
      return unless out_url
      api.get("#{out_url}?format=#{format}").body
    end
  end
end
