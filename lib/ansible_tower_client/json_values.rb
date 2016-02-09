module AnsibleTowerClient
  class JSONValues
    include ValidJSON

    def initialize(vars)
      raise InvalidHash.new(vars) unless vars.kind_of?(Hash)
      @vars = vars
    end

    def extra_vars
      validate(@vars['extra_vars'])
    end

  end
end
