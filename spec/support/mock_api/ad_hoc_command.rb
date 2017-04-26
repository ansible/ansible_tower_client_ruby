module AnsibleTowerClient
  class MockApi
    module AdHocCommand
      def self.collection
        [
          {
            "id"              => 19,
            "type"            => "ad_hoc_command",
            "url"             => "/api/v1/ad_hoc_commands/19/",
            "related"         => {
              "created_by"      => "/api/v1/users/1/",
              "stdout"          => "/api/v1/ad_hoc_commands/19/stdout/",
              "inventory"       => "/api/v1/inventories/2/",
              "credential"      => "/api/v1/credentials/6/",
              "activity_stream" => "/api/v1/ad_hoc_commands/19/activity_stream/",
              "events"          => "/api/v1/ad_hoc_commands/19/events/",
              "cancel"          => "/api/v1/ad_hoc_commands/19/cancel/",
              "relaunch"        => "/api/v1/ad_hoc_commands/19/relaunch/"
            },
            "summary_fields"  => {
              "credential" => {
                "name"        => "appliance",
                "description" => "",
                "kind"        => "ssh",
                "cloud"       => false
              },
              "inventory"  => {
                "name"                            => "AWS",
                "description"                     => "AWS Lab",
                "has_active_failures"             => true,
                "total_hosts"                     => 29,
                "hosts_with_active_failures"      => 29,
                "total_groups"                    => 117,
                "groups_with_active_failures"     => 110,
                "has_inventory_sources"           => true,
                "total_inventory_sources"         => 1,
                "inventory_sources_with_failures" => 0
              },
              "created_by" => {
                "id"         => 1,
                "username"   => "admin",
                "first_name" => "",
                "last_name"  => ""
              }
            },
            "created"         => "2016-01-15T21:07:32.411Z",
            "modified"        => "2016-01-15T21:07:43.927Z",
            "name"            => "ping",
            "launch_type"     => "manual",
            "status"          => "failed",
            "failed"          => true,
            "started"         => "2016-01-15T21:07:43.967Z",
            "finished"        => "2016-01-15T21:07:57.978Z",
            "elapsed"         => 14.011,
            "job_explanation" => "",
            "job_type"        => "run",
            "inventory"       => 2,
            "limit"           => "all",
            "credential"      => 6,
            "module_name"     => "ping",
            "module_args"     => "",
            "forks"           => 0,
            "verbosity"       => 0,
            "become_enabled"  => false
          }.to_json
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
