module AnsibleTowerClient
  class Inventory
    extend CollectionMethods
    include InstanceMethods

    def self.endpoint
      "inventories".freeze
    end
  end
end
