module AnsibleTowerClient
  class Inventory < BaseModel
    def inventory_sources
      Collection.new(api, api.inventory_source_class).find_all_by_url(related['inventory_sources'])
    end

    def update_all_inventory_sources
      inventory_sources.each do |inventory_source|
        inventory_source.update if inventory_source.can_update?
      end
    end

    def root_groups
      Collection.new(api).find_all_by_url(related['root_groups'])
    end
  end
end
