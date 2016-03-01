module AnsibleTowerClient
  class Inventory < BaseModel
    def self.endpoint
      "inventories".freeze
    end

    def root_groups
      self.class.collection_for(api.get(File.join(self.class.endpoint, id.to_s, "root_groups")))
    end
  end
end
