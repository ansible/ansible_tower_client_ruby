module AnsibleTowerClient
  class Host < BaseModel
    def self.endpoint
      "hosts".freeze
    end

    def groups
      Collection.new(api).find_all_by_url(related["groups"])
    end
  end
end
