module AnsibleTowerClient
  class JobTemplate
    extend CollectionMethods
    include InstanceMethods

    def launch
      Api.post("#{url}launch/")
    end

    def self.endpoint
      "job_templates".freeze
    end
  end
end

