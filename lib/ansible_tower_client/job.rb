module AnsibleTowerClient
  class Job
    extend CollectionMethods
    include InstanceMethods

    def self.endpoint
      "jobs".freeze
    end
  end
end

