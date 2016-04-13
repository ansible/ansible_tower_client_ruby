module AnsibleTowerClient
  class JobTemplate < BaseModel
    def launch(options = {})
      launch_url = "#{url}launch/"
      options = options.dup
      new_limit = options.delete(:limit) || options.delete('limit')
      response = with_temporary_changes(new_limit) do
        api.post(launch_url, options).body
      end

      job = JSON.parse(response)
      api.jobs.find(job['job'])
    end

    def survey_spec
      spec_url = related['survey_spec']
      return nil unless spec_url
      api.get(spec_url).body
    end

    def survey_spec_hash
      hashify(:survey_spec)
    end

    def extra_vars_hash
      hashify(:extra_vars)
    end

    def self.endpoint
      "job_templates".freeze
    end

    private

    def with_temporary_changes(in_limit)
      old_limit = limit
      new_limit = in_limit
      patch("{ \"limit\": \"#{new_limit}\" }")
      begin
        yield
      ensure
        patch("{ \"limit\": \"#{old_limit}\" }")
      end
    end

    def patch(body)
      api.patch do |req|
        req.url(url)
        req.headers['Content-Type'] = 'application/json'
        req.body = body
      end
    end
  end
end
