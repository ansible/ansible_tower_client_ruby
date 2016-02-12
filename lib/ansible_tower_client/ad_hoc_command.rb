module AnsibleTowerClient
  class AdHocCommand
    extend CollectionMethods
    include InstanceMethods

    def relaunch
      Api.post("#{url}relaunch/")
    end

    def self.endpoint
      "ad_hoc_commands".freeze
    end
  end
end
