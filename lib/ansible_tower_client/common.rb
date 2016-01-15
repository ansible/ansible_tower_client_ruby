module AnsibleTowerClient
  module Common
    def all
      body = JSON.parse(Api.get(mapping).body)
      results = body["results"]
      loop do
        break if body["next"].nil?
        body = JSON.parse(Api.get(body["next"]).body)
        results += body["results"]
      end

      results.collect { |raw| new(raw) }
    end

    private

    def mapping
      endpoint = {}
      endpoint["AnsibleTowerClient::Host"] = "hosts"
      endpoint["AnsibleTowerClient::JobTemplate"] = "job_templates"
      endpoint["AnsibleTowerClient::AdHocCommand"] = "ad_hoc_commands"
      endpoint[self.to_s]
    end
  end
end

