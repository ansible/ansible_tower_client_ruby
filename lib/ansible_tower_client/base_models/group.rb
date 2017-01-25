module AnsibleTowerClient
  class Group < BaseModel
    def children
      Collection.new(api).find_all_by_url(related["children"])
    end
  end
end
