module AnsibleTowerClient
  class JobTemplate
    extend CollectionMethods
    include InstanceMethods

    attr_reader :response

    def launch(vars = {})
      launch_url = "#{url}launch/"
      @response = Api.post(launch_url, vars).body
    end

    def extra_vars
      @raw_body['extra_vars']
    end

    def self.endpoint
      "job_templates".freeze
    end
  end
end

