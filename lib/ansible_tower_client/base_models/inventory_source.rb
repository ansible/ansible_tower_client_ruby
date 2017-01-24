module AnsibleTowerClient
  class InventorySource < BaseModel
    def can_update?
      response = api.get(related['update'].to_s).body

      updatable = JSON.parse(response)
      updatable['can_update']
    end

    def update
      response = api.post(related['update'].to_s).body

      update = JSON.parse(response)
      api.inventory_updates.find(update['inventory_update'])
    end
  end
end
