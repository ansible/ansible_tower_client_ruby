module AnsibleTowerClient
  class SystemJobTemplate < BaseModel
    def schedules
      Collection.new(api).find_all_by_url(related["schedules"])
    end
  end
end
