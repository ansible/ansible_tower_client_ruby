module AnsibleTowerClient
  class Group < BaseModel
    def self.endpoint
      "groups".freeze
    end

    def children
      self.class.collection_for(api.get(File.join(self.class.endpoint, id.to_s, "children")))
    end
  end
end
