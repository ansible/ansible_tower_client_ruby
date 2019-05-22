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
      return @last_update if defined? @last_update
      return @last_update = nil unless related.raw_hash.key?('last_update')
      return @last_update = nil if (update_id = related.last_update).blank?

      if !numberish?(update_id)
        if raw_hash.key?('summary_fields') && summary_fields.raw_hash.key?('last_update')
          update_id = summary_fields.last_update.id
        else
          /\/(?'update_id'\d+)\/?\z/ =~ update_id
        end
      end

      @last_update = update_id && api.project_updates.find(update_id)
    end

    private

    def numberish?(value)
      value.kind_of?(Numeric) || value.to_s =~ /\A\d+\z/
    end
  end
end
