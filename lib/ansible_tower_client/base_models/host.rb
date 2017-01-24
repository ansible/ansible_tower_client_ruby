module AnsibleTowerClient
  class Host < BaseModel
    def groups
      Collection.new(api).find_all_by_url(related["groups"])
    end
  end
end
