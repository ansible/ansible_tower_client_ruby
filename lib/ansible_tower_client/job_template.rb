module AnsibleTowerClient
  class JobTemplate
    extend CollectionMethods
    include InstanceMethods

    attr_reader :extra_vars

    def initialize(raw_body)
      @extra_vars = raw_body['extra_vars']
      super
    end

    def launch(vars = {})
      launch_url = "#{url}launch/"
      resp = Api.post(launch_url, vars).body
      job = JSON.parse(resp)
      Job.find(job['job'])
    end

    def self.endpoint
      "job_templates".freeze
    end
  end
end

