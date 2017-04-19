module AnsibleTowerClient
  class MockApi
    module Credential
      def self.collection
        [
          {
            "id"                 => 47,
            "type"               => "credential",
            "url"                => "/api/v1/credentials/47/",
            "related"            => {
              "created_by"      => "/api/v1/users/1/",
              "modified_by"     => "/api/v1/users/1/",
              "organization"    => "/api/v1/organizations/1/",
              "owner_teams"     => "/api/v1/credentials/47/owner_teams/",
              "owner_users"     => "/api/v1/credentials/47/owner_users/",
              "activity_stream" => "/api/v1/credentials/47/activity_stream/",
              "access_list"     => "/api/v1/credentials/47/access_list/",
              "object_roles"    => "/api/v1/credentials/47/object_roles/"
            },
            "summary_fields"     => {
              "host"         => {},
              "project"      => {},
              "organization" => {
                "id"          => 1,
                "name"        => "Default",
                "description" => ""
              },
              "created_by"   => {
                "id"         => 1,
                "username"   => "admin",
                "first_name" => "",
                "last_name"  => ""
              },
              "modified_by"  => {
                "id"         => 1,
                "username"   => "admin",
                "first_name" => "",
                "last_name"  => ""
              },
              "object_roles" => {
                "admin_role" => {
                  "description" => "Can manage all aspects of the credential",
                  "id"          => 1668,
                  "name"        => "Admin"
                },
                "use_role"   => {
                  "description" => "Can use the credential in a job template",
                  "id"          => 1670,
                  "name"        => "Use"
                },
                "read_role"  => {
                  "description" => "May view settings for the credential",
                  "id"          => 1669,
                  "name"        => "Read"
                }
              },
              "owners"       => []
            },
            "created"            => "2017-03-27T19:06:13.710Z",
            "modified"           => "2017-03-27T19:13:51.406Z",
            "name"               => "abc",
            "description"        => "",
            "kind"               => "aws",
            "cloud"              => true,
            "host"               => "",
            "username"           => "a",
            "password"           => "$encrypted$",
            "security_token"     => "$encrypted$",
            "project"            => "",
            "domain"             => "",
            "ssh_key_data"       => "",
            "ssh_key_unlock"     => "",
            "become_method"      => "",
            "become_username"    => "",
            "become_password"    => "",
            "vault_password"     => "",
            "subscription"       => "",
            "tenant"             => "",
            "secret"             => "",
            "client"             => "",
            "authorize"          => false,
            "authorize_password" => ""
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
