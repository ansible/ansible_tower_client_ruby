module AnsibleTowerClient
  class AdHocCommand < BaseModel
    def relaunch
      api.post("#{url}relaunch/")
    end

    def self.endpoint
      "ad_hoc_commands".freeze
    end
  end
end

