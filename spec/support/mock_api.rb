module AnsibleTowerClient
  class MockApi
    class Response
      attr_reader :body
      def initialize(body)
        @body = body
      end
    end

    def get(path, get_options = nil)
      suffix = path.split("api/v1/").last
      case suffix
      when "ad_hoc_commands"
        wrap_response(AdHocCommand.response)
      when "config"
        wrap_response(Config.response)
      when "me"
        wrap_response(Me.response)
      end
    end

    def wrap_response(data)
      AnsibleTowerClient::MockApi::Response.new(data)
    end
  end
end
