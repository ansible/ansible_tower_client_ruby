require "ansible_tower_client/logging"
require "ansible_tower_client/null_logger"
require "ansible_tower_client/version"
require "ansible_tower_client/common"

require "ansible_tower_client/api"
require "ansible_tower_client/connection"
require "ansible_tower_client/host"
require "ansible_tower_client/job_template"
require "ansible_tower_client/ad_hoc_command"
require "json"
require "more_core_extensions/all"

module AnsibleTowerClient
  class << self
    attr_accessor :logger
  end

  def self.logger
    @logger ||= NullLogger.new
  end
end
