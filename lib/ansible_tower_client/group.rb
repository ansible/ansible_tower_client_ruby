module AnsibleTowerClient
  class Group
    extend CollectionMethods
    include InstanceMethods

    def self.endpoint
      "groups".freeze
    end
  end
end
