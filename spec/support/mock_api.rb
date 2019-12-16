module AnsibleTowerClient
  class MockApi
    class Response
      attr_reader :body, :url

      def initialize(body, url = nil)
        @body = body
        @url  = url
      end
    end

    RESPONSE_DATA_DIR = Pathname.new(__dir__).join("mock_api")

    def initialize(version = nil)
      @version = version
    end

    def get(path, get_options = nil)
      suffix = path.split("api/v1/").last
      suffix = suffix[0..-2] if suffix.end_with?('/')
      collection = JSON.parse(RESPONSE_DATA_DIR.join("#{suffix}.json").read)

      response_data =
        if suffix == 'config'
          collection["version"] = @version.to_s
          collection
        else
          {
            "count"    => collection.length,
            "next"     => nil,
            "previous" => nil,
            "results"  => collection
          }
        end

      AnsibleTowerClient::MockApi::Response.new(response_data.to_json, path)
    end
  end
end
