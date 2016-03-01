module AnsibleTowerClient
  class Job < BaseModel
    def self.endpoint
      "jobs".freeze
    end
  end
end

