module AnsibleTowerClient
  class Host
    extend CollectionMethods
    include InstanceMethods

    attr_reader :instance_id

    def initialize(raw_body)
      @instance_id = raw_body["instance_id"]
      super
    end

    def self.endpoint
      "hosts".freeze
    end
  end
end
