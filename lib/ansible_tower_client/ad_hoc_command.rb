module AnsibleTowerClient
  class AdHocCommand
    extend Common
    attr_reader :id
    attr_reader :name
    attr_reader :raw_ad_hoc_common_body

    def initialize(raw_ad_hoc_command)
      @id   = raw_ad_hoc_command["id"]
      @name = raw_ad_hoc_command["name"]
      @raw_ad_hoc_command_body = raw_ad_hoc_command
    end
  end
end

