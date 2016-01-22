module AnsibleTowerClient
  class Host
    extend CollectionMethods
    attr_reader :id
    attr_reader :name
    attr_reader :instance_id
    attr_reader :url
    attr_reader :raw_host_body

    def initialize(raw_host)
      @id            = raw_host["id"]
      @name          = raw_host["name"]
      @instance_id   = raw_host["instance_id"]
      @url           = raw_host["url"]
      @raw_host_body = raw_host
    end

    def self.endpoint
      "hosts".freeze
    end
  end
end
