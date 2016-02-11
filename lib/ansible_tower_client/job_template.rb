module AnsibleTowerClient
  class JobTemplate
    extend CollectionMethods
    include InstanceMethods

    attr_reader :extra_vars, :description

    def initialize(raw_body)
      @extra_vars  = raw_body['extra_vars']
      @description = raw_body['description']
      super
    end

    def launch(vars = {})
      launch_url = "#{url}launch/"
      extra = JSONValues.new(vars).extra_vars
      resp = Api.post(launch_url, extra).body
      job = JSON.parse(resp)
      Job.find(job['job'])
    end

    def self.endpoint
      "job_templates".freeze
    end
  end
end

