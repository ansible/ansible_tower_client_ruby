module AnsibleTowerClient
  class Credential < BaseModel
    def override_raw_attributes
      { :organization => :organization_id }
    end
  end
end
