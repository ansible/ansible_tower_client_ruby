module AnsibleTowerClient
  class BaseModel
    attr_reader :api

    def initialize(api, _raw_body)
      @api = api
    end
  end
end
