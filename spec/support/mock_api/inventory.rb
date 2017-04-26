module AnsibleTowerClient
  class MockApi
    module Inventory
      def self.collection
        [
          {
            "id"                              => 6,
            "type"                            => "inventory",
            "url"                             => "/api/v1/inventories/6/",
            "related"                         => {
              "created_by"         => "/api/v1/users/1/",
              "job_templates"      => "/api/v1/inventories/6/job_templates/",
              "scan_job_templates" => "/api/v1/inventories/6/scan_job_templates/",
              "variable_data"      => "/api/v1/inventories/6/variable_data/",
              "root_groups"        => "/api/v1/inventories/6/root_groups/",
              "object_roles"       => "/api/v1/inventories/6/object_roles/",
              "ad_hoc_commands"    => "/api/v1/inventories/6/ad_hoc_commands/",
              "script"             => "/api/v1/inventories/6/script/",
              "tree"               => "/api/v1/inventories/6/tree/",
              "access_list"        => "/api/v1/inventories/6/access_list/",
              "hosts"              => "/api/v1/inventories/6/hosts/",
              "groups"             => "/api/v1/inventories/6/groups/",
              "activity_stream"    => "/api/v1/inventories/6/activity_stream/",
              "inventory_sources"  => "/api/v1/inventories/6/inventory_sources/",
              "organization"       => "/api/v1/organizations/3/"
            },
            "summary_fields"                  => {
              "organization" => {
                "id"          => 3,
                "name"        => "ACME Corp",
                "description" => "Which belongs to goern"
              },
              "created_by"   => {
                "id"         => 1,
                "username"   => "admin",
                "first_name" => "",
                "last_name"  => ""
              },
              "object_roles" => {
                "use_role"    => {
                  "description" => "Can use the inventory in a job template",
                  "id"          => 110,
                  "name"        => "Use"
                },
                "admin_role"  => {
                  "description" => "Can manage all aspects of the inventory",
                  "id"          => 108,
                  "name"        => "Admin"
                },
                "adhoc_role"  => {
                  "description" => "May run ad hoc commands on an inventory",
                  "id"          => 107,
                  "name"        => "Ad Hoc"
                },
                "update_role" => {
                  "description" => "May update project or inventory or group using the configured source update system",
                  "id"          => 111,
                  "name"        => "Update"
                },
                "read_role"   => {
                  "description" => "May view settings for the inventory",
                  "id"          => 109,
                  "name"        => "Read"
                }
              }
            },
            "created"                         => "2017-01-30T10:53:48.130Z",
            "modified"                        => "2017-02-23T17:43:39.928Z",
            "name"                            => "acme-corp",
            "description"                     => "",
            "organization"                    => 3,
            "variables"                       => "---\nOCP_URL: https://acme-ocp3-haproxy-0.acme.e2e.example.com:8443\nOCP_MASTER: acme-ocp3-haproxy-0.acme.e2e.example.com\nOCP_USER: pltops\n\nOCP_PROJECT: coolstore-dev\nARTIFACTORY_API_URL: http://acme-dev-infra-artifactory.acme.e2e.example.com:8081/artifactory/api/",
            "has_active_failures"             => true,
            "total_hosts"                     => 1,
            "hosts_with_active_failures"      => 1,
            "total_groups"                    => 2,
            "groups_with_active_failures"     => 1,
            "has_inventory_sources"           => true,
            "total_inventory_sources"         => 1,
            "inventory_sources_with_failures" => 1
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
