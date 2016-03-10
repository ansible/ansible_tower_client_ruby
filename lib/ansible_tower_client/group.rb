module AnsibleTowerClient
  class Group < BaseModel
    include InstanceMethods

    attr_reader :inventory_id

    def initialize(api, raw_body)
      @inventory_id = raw_body["inventory"]
      super
    end

    def self.endpoint
      "groups".freeze
    end

    def children
      self.class.collection_for(api.get(File.join(self.class.endpoint, id.to_s, "children")))
    end
  end
end
