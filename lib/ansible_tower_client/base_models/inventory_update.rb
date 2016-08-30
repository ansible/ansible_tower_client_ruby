module AnsibleTowerClient
  class InventoryUpdate < BaseModel
    def self.endpoint
      "inventory_updates".freeze
    end
  end
end
