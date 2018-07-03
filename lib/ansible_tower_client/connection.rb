module AnsibleTowerClient
  class Connection
    attr_reader :options

    # Options:
    # - base_url: you have two options here:
    #   a) pass in only scheme and hostname e.g. 'https://localhost:54321' to allow client to connect to both api v1
    #      and v2 versions like this: `client.api(:version => 1)` and `client.api(:version => 2)`. This requires ansible
    #      tower API being accessible directly at `https://localhost:54321/api/v1` and `https://localhost:54321/api/v2`.
    #   b) pass in a complete api address e.g. 'https://localhost:54321/tower'. Client will then connect to the path
    #      directly and it's your responsibility to know what version of API is there.
    # - username
    # - password
    # - verify_ssl
    def initialize(options = {})
      raise "Credentials are required" unless options[:username] && options[:password]
      raise ":base_url is required" unless options[:base_url]
      logger = options[:logger] || AnsibleTowerClient.logger

      require 'faraday'
      require 'faraday_middleware'
      require 'ansible_tower_client/middleware/raise_tower_error'
      Faraday::Response.register_middleware :raise_tower_error => -> { Middleware::RaiseTowerError }

      @options = {
        :url        => options[:base_url],
        :verify_ssl => (options[:verify_ssl] || OpenSSL::SSL::VERIFY_PEER) != OpenSSL::SSL::VERIFY_NONE,
        :username   => options[:username],
        :password   => options[:password],
        :logger     => logger,
      }

      reset
    end

    def connection(url:, username:, password:, verify_ssl: false, logger: nil)
      Faraday.new(url, :ssl => {:verify => verify_ssl}) do |f|
        f.use(FaradayMiddleware::EncodeJson)
        f.use(FaradayMiddleware::FollowRedirects, :limit => 3, :standards_compliant => true)
        f.request(:url_encoded)
        f.response(:raise_tower_error)
        f.response(:logger, logger)
        f.adapter(Faraday.default_adapter)
        f.basic_auth(username, password)
      end
    end

    def api(version: 2)
      @api[version] ||= begin
        # Build uri path.
        options = @options.clone.tap do |opts|
          opts[:url] = URI(opts[:url]).tap { |url| url.path = url_path_for_version(url.path, version) }
        end

        Api.new(connection(**options), version)
      end
    end

    def reset
      @api = {}
    end

    private

    def url_path_for_version(orig_path, api_version)
      return orig_path unless orig_path.sub(/\/$/, "").empty?
      "/api/v#{api_version}"
    end
  end
end
