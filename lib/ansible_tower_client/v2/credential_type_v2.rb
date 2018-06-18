module AnsibleTowerClient
  class CredentialTypeV2 < BaseModel
    class Inputs < BaseModel; end

    def self.endpoint
      'credential_types'
    end
  end
end
