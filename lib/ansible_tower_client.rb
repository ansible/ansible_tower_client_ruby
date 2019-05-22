require "json"
require "yaml"
require "ansible_tower_client/exception"
require "ansible_tower_client/logging"
require "ansible_tower_client/null_logger"
require "ansible_tower_client/version"

require "ansible_tower_client/connection"
require "ansible_tower_client/api"
require "ansible_tower_client/hash_model"
require "ansible_tower_client/base_model"
require "ansible_tower_client/collection"

require "ansible_tower_client/base_models/activity_stream"
require "ansible_tower_client/base_models/ad_hoc_command"
require "ansible_tower_client/base_models/credential"
require "ansible_tower_client/base_models/credential_type"
require "ansible_tower_client/base_models/group"
require "ansible_tower_client/base_models/host"
require "ansible_tower_client/base_models/inventory"
require "ansible_tower_client/base_models/inventory_source"
require "ansible_tower_client/base_models/inventory_update"
require "ansible_tower_client/base_models/job"
require "ansible_tower_client/base_models/job_event"
require "ansible_tower_client/base_models/job_template"
require "ansible_tower_client/base_models/organization"
require "ansible_tower_client/base_models/project"
require "ansible_tower_client/base_models/project_update"
require "ansible_tower_client/base_models/schedule"
require "ansible_tower_client/base_models/system_job"
require "ansible_tower_client/base_models/system_job_template"
require "ansible_tower_client/base_models/workflow_job_node"
require "ansible_tower_client/base_models/workflow_job"
require "ansible_tower_client/base_models/workflow_job_template"
require "ansible_tower_client/base_models/workflow_job_template_node"

require "ansible_tower_client/v2/job_template_v2"

require "more_core_extensions/all"
require "active_support/inflector"

module AnsibleTowerClient
  class << self
    attr_accessor :logger
  end

  def self.logger
    @logger ||= NullLogger.new
  end
end
