module AnsibleTowerClient
  class Group < BaseModel
    def self.endpoint
      "groups".freeze
    end

    def children
      Collection.new(api).find_all_by_url(related["children"])
    end
  end
end
