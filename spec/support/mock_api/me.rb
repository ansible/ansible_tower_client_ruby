module AnsibleTowerClient
  class MockApi
    module Me
      def self.collection
        [
          {
            "id"                => 1,
            "type"              => "user",
            "url"               => "/api/v1/users/1/",
            "related"           => {
              "admin_of_organizations" => "/api/v1/users/1/admin_of_organizations/",
              "organizations"          => "/api/v1/users/1/organizations/",
              "roles"                  => "/api/v1/users/1/roles/",
              "access_list"            => "/api/v1/users/1/access_list/",
              "teams"                  => "/api/v1/users/1/teams/",
              "credentials"            => "/api/v1/users/1/credentials/",
              "activity_stream"        => "/api/v1/users/1/activity_stream/",
              "projects"               => "/api/v1/users/1/projects/"
            },
            "created"           => "2016-08-02T17:56:37.162Z",
            "username"          => "admin",
            "first_name"        => "",
            "last_name"         => "",
            "email"             => "admin@example.com",
            "is_superuser"      => true,
            "is_system_auditor" => false,
            "ldap_dn"           => "",
            "external_account"  => nil,
            "auth"              => []
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
