module AnsibleTowerClient
  module InstanceMethods
    attr_reader :id, :name, :url, :raw_body

    def initialize(_api, raw_body)
      super
      @id       = raw_body["id"]
      @name     = raw_body["name"]
      @url      = raw_body["url"]
      @raw_body = raw_body
    end

    def related
      @raw_body['related']
    end

    def summary_fields
      @raw_body['summary_fields']
    end
  end
end
