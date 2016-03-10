module AnsibleTowerClient
  class Job < BaseModel
    include InstanceMethods

    def self.endpoint
      "jobs".freeze
    end
  end
end

