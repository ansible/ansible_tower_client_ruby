module AnsibleTowerClient
  class Credential < BaseModel
    def self.endpoint
      "credentials".freeze
    end
  end
end
