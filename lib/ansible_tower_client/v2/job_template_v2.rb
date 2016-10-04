module AnsibleTowerClient
  class JobTemplateV2 < JobTemplate
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
