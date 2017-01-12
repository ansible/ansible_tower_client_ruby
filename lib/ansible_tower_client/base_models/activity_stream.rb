module AnsibleTowerClient
  class ActivityStream < BaseModel
    def self.endpoint
      "activity_stream".freeze
    end
  end
end
