module AnsibleTowerClient
  class Host
    attr_reader :id
    attr_reader :name
    attr_reader :instance_id
    attr_reader :url
    attr_reader :raw_host_body

    def self.all
      body = JSON.parse(Api.get("hosts").body)
      results = body["results"]
      loop do
        break if body["next"].nil?
        body = JSON.parse(Api.get(body["next"]).body)
        results += body["results"]
      end

      results.collect { |raw_host| new(raw_host) }
    end

    def initialize(raw_host)
      @id            = raw_host["id"]
      @name          = raw_host["name"]
      @instance_id   = raw_host["instance_id"]
      @url           = raw_host["url"]
      @raw_host_body = raw_host
    end
  end
end
