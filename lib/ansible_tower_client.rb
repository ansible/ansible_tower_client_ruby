require "ansible_tower_client/logging"
require "ansible_tower_client/null_logger"
require "ansible_tower_client/version"

module AnsibleTowerClient
  class << self
    attr_accessor :logger
  end

  def self.logger
    @logger ||= NullLogger.new
  end
end
