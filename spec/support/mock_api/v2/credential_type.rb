module AnsibleTowerClient
  class MockApi
    module CredentialTypeV2
      def self.collection
        [
          {
            :id               => 16,
            :type             => "credential_type",
            :url              => "/api/v2/credential_types/16/",
            :related          => {
              :created_by      => "/api/v2/users/1/",
              :modified_by     => "/api/v2/users/1/",
              :credentials     => "/api/v2/credential_types/16/credentials/",
              :activity_stream => "/api/v2/credential_types/16/activity_stream/"
            },
            :summary_fields   => {
              :created_by        => {:id => 1, :username => "admin", :first_name => "", :last_name => ""},
              :modified_by       => {:id => 1, :username => "admin", :first_name => "", :last_name => ""},
              :user_capabilities => {:edit => true, :delete => true}
            },
            :created          => "2018-06-18T20:02:15.415325Z",
            :modified         => "2018-06-18T20:02:15.415353Z",
            :name             => "Nuage",
            :description      => "",
            :kind             => "cloud",
            :managed_by_tower => false,
            :inputs           => {
              :fields   => [
                {:type => "string", :id => "nuage_username", :label => "Username"},
                {:secret => true, :type => "string", :id => "nuage_password", :label => "Password"},
                {:type => "string", :id => "nuage_enterprise", :label => "Enterprise"},
                {:type => "string", :id => "nuage_url", :label => "URL"},
                {:choices => %w(v4_0 v5_0), :type => "string", :id => "nuage_version", :label => "Version"}
              ],
              :required => %w(nuage_username nuage_password nuage_enterprise nuage_url nuage_version)
            },
            :injectors        => {
              :extra_vars => {
                :nuage_username   => "{{ nuage_username }}",
                :nuage_password   => "{{ nuage_password }}",
                :nuage_version    => "{{ nuage_version }}",
                :nuage_enterprise => "{{ nuage_enterprise }}",
                :nuage_url        => "{{ nuage_url }}"
              }
            }
          }
        ]
      end

      def self.response
        {
          "count"    => collection.length,
          "next"     => nil,
          "previous" => nil,
          "results"  => collection
        }.to_json
      end
    end
  end
end
