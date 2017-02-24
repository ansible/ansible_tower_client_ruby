module AnsibleTowerClient
  class Job < BaseModel
    def extra_vars_hash
      extra_vars.empty? ? {} : hashify(:extra_vars)
    end

    def job_plays
      Collection.new(api).find_all_by_url(related["job_plays"])
    end

    def stdout
      out_url = related['stdout']
      return unless out_url
      api.get("#{out_url}?format=txt").body
    end
  end
end
