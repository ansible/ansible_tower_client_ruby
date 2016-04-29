module AnsibleTowerClient
  class Host < BaseModel
    def self.endpoint
      "hosts".freeze
    end

    def groups
      self.class.find_all_by_url(File.join(self.class.endpoint, id.to_s, "groups"))
    end
  end
end
