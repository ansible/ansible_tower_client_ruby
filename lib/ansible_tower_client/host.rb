module AnsibleTowerClient
  class Host
    extend CollectionMethods
    include InstanceMethods

    attr_reader :instance_id, :inventory_id

    def initialize(raw_body)
      @instance_id  = raw_body["instance_id"]
      @inventory_id = raw_body["inventory"]
      super
    end

    def self.endpoint
      "hosts".freeze
    end

    def groups
      self.class.collection_for(Api.get(File.join(self.class.endpoint, id.to_s, "groups")))
    end
  end
end
