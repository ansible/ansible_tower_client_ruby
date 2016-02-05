module AnsibleTowerClient
  class TowerHash
    include Validation

    def initialize(vars)
      raise InvalidHash.new(vars) unless vars.is_a?(Hash)
      @extra_vars = vars['extra_vars']
    end

  end
end
