module AnsibleTowerClient
  module Middleware
    class RaiseTowerError < Faraday::Response::Middleware
      include Logging
      CLIENT_ERROR_STATUSES = 400...600

      def on_complete(env)
        return unless CLIENT_ERROR_STATUSES.include?(env[:status])
        logger.debug { "#{self.class.name} Raw Response:\n#{env.pretty_inspect}" }
        message   = JSON.parse(env.body).pretty_inspect rescue nil
        message ||= env.body
        logger.error("#{self.class.name} Response Body:\n#{message}")

        case env[:status]
        when 402
          raise AnsibleTowerClient::UnlicensedFeatureError
        when 404
          raise AnsibleTowerClient::ResourceNotFoundError, response_values(env)
        when 407
          # mimic the behavior that we get with proxy requests with HTTPS
          raise AnsibleTowerClient::ConnectionError, %(407 "Proxy Authentication Required ")
        else
          raise AnsibleTowerClient::ClientError, env.body
        end
      end

      def response_values(env)
        {:status => env.status, :headers => env.response_headers, :body => env.body}
      end
    end
  end
end
