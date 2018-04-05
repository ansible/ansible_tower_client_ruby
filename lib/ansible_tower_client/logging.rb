require 'forwardable'
module AnsibleTowerClient
  module Logging
    extend Forwardable
    delegate :logger => :AnsibleTowerClient

    def log_from_response(response)
      JSON.parse(response.body).pretty_inspect
    rescue JSON::ParserError
      response.body
    end
  end
end
