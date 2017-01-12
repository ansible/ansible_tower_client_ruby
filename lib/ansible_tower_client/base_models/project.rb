module AnsibleTowerClient
  class Project < BaseModel
    def self.endpoint
      "projects".freeze
    end
  end
end
