module AnsibleTowerClient
  class Project < BaseModel
    def self.endpoint
      "projects".freeze
    end

    def playbooks
      Collection.new(api).find_all_by_url(related['playbooks'])
    end
  end
end
