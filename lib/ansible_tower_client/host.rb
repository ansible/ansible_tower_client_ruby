module AnsibleTowerClient
  class Host < BaseModel
    def self.endpoint
      "hosts".freeze
    end

    def groups
      self.class.collection_for(api.get(File.join(self.class.endpoint, id.to_s, "groups")))
    end
  end
end
