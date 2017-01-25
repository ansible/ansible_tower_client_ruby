module AnsibleTowerClient
  class AdHocCommand < BaseModel
    def relaunch
      api.post("#{url}relaunch/")
    end
  end
end
