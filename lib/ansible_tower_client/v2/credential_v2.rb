module AnsibleTowerClient
  class CredentialV2 < Credential
    class Inputs < BaseModel
      def size
        @raw_hash.keys.size
      end
    end

    def self.endpoint
      'credentials'
    end
  end
end
