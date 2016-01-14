module AnsibleTowerClient
  class Connection
    def initialize(options)
      raise "Credentials are required" unless options[:username] && options[:password]
      raise ":base_url is required" unless options[:base_url]
      verify_ssl = options[:verify_ssl] || OpenSSL::SSL::VERIFY_PEER
      verify_ssl = verify_ssl == OpenSSL::SSL::VERIFY_NONE ? false : true
      options = options.dup
      options[:verify_ssl] = verify_ssl
      Api.instance(options)
    end

    def hosts
      Host
    end

    def config
      JSON.parse(Api.get("config").body)
    end

    def version
      config["version"]
    end

    def verify_credentials
      JSON.parse(Api.get("me").body).fetch_path("results", 0, "username")
    end
  end
end
