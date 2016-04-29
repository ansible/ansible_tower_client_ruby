module AnsibleTowerClient
  class Group < BaseModel
    def self.endpoint
      "groups".freeze
    end

    def children
      self.class.find_all_by_url(File.join(self.class.endpoint, id.to_s, "children"))
    end
  end
end
