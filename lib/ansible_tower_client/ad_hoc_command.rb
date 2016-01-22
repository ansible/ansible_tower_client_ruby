module AnsibleTowerClient
  class AdHocCommand
    extend CollectionMethods
    attr_reader :id
    attr_reader :name
    attr_reader :url
    attr_reader :raw_body

    def initialize(raw_body)
      @id   = raw_body["id"]
      @name = raw_body["name"]
      @url  = raw_body["url"]
      @raw_body = raw_body
    end

    def relaunch
      Api.post("#{url}relaunch/")
    end

    def self.endpoint
      "ad_hoc_commands".freeze
    end
  end
end

