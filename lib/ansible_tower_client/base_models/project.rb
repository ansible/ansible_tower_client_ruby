module AnsibleTowerClient
  class Project < BaseModel
    def playbooks
      Collection.new(api).find_all_by_url(related['playbooks'])
    end

    def can_update?
      response  = api.get(related['update'].to_s).body
      updatable = JSON.parse(response)

      updatable['can_update']
    end

    def update
      response = api.post(related['update'].to_s).body
      update   = JSON.parse(response)

      api.project_updates.find(update['project_update'])
    end

    def last_update
      return if related['last_update'].blank?
      api.project_updates.find(related['last_update'])
    end
  end
end
