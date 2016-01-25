module AnsibleTowerClient
  class Host
    extend CollectionMethods
    include InstanceMethods

    attr_reader :id, :name, :url, :raw_body

    def initialize(raw_body)
      @id            = raw_body["id"]
      @name          = raw_body["name"]
      @instance_id   = raw_body["instance_id"]
      @url           = raw_body["url"]
      @raw_body      = raw_body
    end

    def self.endpoint
      "hosts".freeze
    end
  end
end
