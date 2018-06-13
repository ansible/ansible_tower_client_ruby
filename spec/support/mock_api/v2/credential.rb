module AnsibleTowerClient
  class MockApi
    module CredentialV2
      def self.collection
        [
          {
            :id              => 2,
            :type            => "credential",
            :url             => "/api/v2/credentials/2/",
            :related         => {
              :created_by      => "/api/v2/users/1/",
              :modified_by     => "/api/v2/users/1/",
              :organization    => "/api/v2/organizations/2/",
              :owner_users     => "/api/v2/credentials/2/owner_users/",
              :object_roles    => "/api/v2/credentials/2/object_roles/",
              :owner_teams     => "/api/v2/credentials/2/owner_teams/",
              :copy            => "/api/v2/credentials/2/copy/",
              :activity_stream => "/api/v2/credentials/2/activity_stream/",
              :access_list     => "/api/v2/credentials/2/access_list/",
              :credential_type => "/api/v2/credential_types/1/"
            },
            :summary_fields  => {
              :host              => {},
              :project           => {},
              :organization      => {
                :id          => 2,
                :name        => "ManageIQ",
                :description => "ManageIQ Default Organization"
              },
              :created_by        => {
                :id         => 1,
                :username   => "admin",
                :first_name => "",
                :last_name  => ""
              },
              :modified_by       => {
                :id         => 1,
                :username   => "admin",
                :first_name => "",
                :last_name  => ""
              },
              :object_roles      => {
                :admin_role => {
                  :id          => 35,
                  :description => "Can manage all aspects of the credential",
                  :name        => "Admin"
                },
                :use_role   => {
                  :id          => 37,
                  :description => "Can use the credential in a job template",
                  :name        => "Use"
                },
                :read_role  => {
                  :id          => 36,
                  :description => "May view settings for the credential",
                  :name        => "Read"
                }
              },
              :user_capabilities => {
                :edit   => true,
                :copy   => true,
                :delete => true
              },
              :owners            => [
                {
                  :url         => "/api/v2/organizations/2/",
                  :description => "ManageIQ Default Organization",
                  :type        => "organization",
                  :id          => 2,
                  :name        => "ManageIQ"
                }
              ]
            },
            :created         => "2018-06-11T07:47:45.503385Z",
            :modified        => "2018-06-11T07:47:45.567457Z",
            :name            => "ManageIQ Default Credential",
            :description     => "",
            :organization    => 2,
            :credential_type => 1,
            :inputs          => {}
          },
          {
            :id              => 3,
            :type            => "credential",
            :url             => "/api/v2/credentials/3/",
            :related         => {
              :created_by      => "/api/v2/users/1/",
              :modified_by     => "/api/v2/users/1/",
              :owner_users     => "/api/v2/credentials/3/owner_users/",
              :object_roles    => "/api/v2/credentials/3/object_roles/",
              :owner_teams     => "/api/v2/credentials/3/owner_teams/",
              :copy            => "/api/v2/credentials/3/copy/",
              :activity_stream => "/api/v2/credentials/3/activity_stream/",
              :access_list     => "/api/v2/credentials/3/access_list/",
              :credential_type => "/api/v2/credential_types/16/",
              :user            => "/api/v2/users/1/"
            },
            :summary_fields  => {
              :host              => {},
              :project           => {},
              :created_by        => {
                :id         => 1,
                :username   => "admin",
                :first_name => "",
                :last_name  => ""
              },
              :modified_by       => {
                :id         => 1,
                :username   => "admin",
                :first_name => "",
                :last_name  => ""
              },
              :object_roles      => {
                :admin_role => {
                  :id          => 43,
                  :description => "Can manage all aspects of the credential",
                  :name        => "Admin"
                },
                :use_role   => {
                  :id          => 45,
                  :description => "Can use the credential in a job template",
                  :name        => "Use"
                },
                :read_role  => {
                  :id          => 44,
                  :description => "May view settings for the credential",
                  :name        => "Read"
                }
              },
              :user_capabilities => {
                :edit   => true,
                :copy   => true,
                :delete => true
              },
              :owners            => [
                {
                  :url         => "/api/v2/users/1/",
                  :description => " ",
                  :type        => "user",
                  :id          => 1,
                  :name        => "admin"
                }
              ]
            },
            :created         => "2018-06-11T10:56:56.150390Z",
            :modified        => "2018-06-11T10:56:56.247713Z",
            :name            => "NuageGUI",
            :description     => "",
            :organization    => nil,
            :credential_type => 16,
            :inputs          => {
              :nuage_username   => "myusername",
              :nuage_password   => "$encrypted$",
              :nuage_version    => "v5_0",
              :nuage_enterprise => "myenterprise",
              :nuage_url        => "myurl.com"
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
