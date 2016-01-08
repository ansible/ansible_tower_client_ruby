module AnsibleTowerClient
  module Logging
    extend Forwardable
    delegate :logger => :AnsibleTowerClient
  end
end
