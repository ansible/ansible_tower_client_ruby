module AnsibleTowerClient
  class MockApi
    module Host
      def self.collection
        [
          {
            "id"                    => 144,
            "type"                  => "host",
            "url"                   => "/api/v1/hosts/144/",
            "related"               => {
              "created_by"            => "/api/v1/users/1/",
              "job_host_summaries"    => "/api/v1/hosts/144/job_host_summaries/",
              "variable_data"         => "/api/v1/hosts/144/variable_data/",
              "job_events"            => "/api/v1/hosts/144/job_events/",
              "ad_hoc_commands"       => "/api/v1/hosts/144/ad_hoc_commands/",
              "fact_versions"         => "/api/v1/hosts/144/fact_versions/",
              "inventory_sources"     => "/api/v1/hosts/144/inventory_sources/",
              "groups"                => "/api/v1/hosts/144/groups/",
              "activity_stream"       => "/api/v1/hosts/144/activity_stream/",
              "all_groups"            => "/api/v1/hosts/144/all_groups/",
              "ad_hoc_command_events" => "/api/v1/hosts/144/ad_hoc_command_events/",
              "inventory"             => "/api/v1/inventories/39/",
              "last_job"              => "/api/v1/jobs/530/",
              "last_job_host_summary" => "/api/v1/job_host_summaries/286/"
            },
            "summary_fields"        => {
              "last_job"              => {
                "id"                => 530,
                "name"              => "Test_provision",
                "description"       => "Test",
                "finished"          => "2017-03-23T16:15:04.808Z",
                "status"            => "failed",
                "failed"            => true,
                "job_template_id"   => 412,
                "job_template_name" => "Test_provision"
              },
              "last_job_host_summary" => {
                "id"     => 286,
                "failed" => true
              },
              "inventory"             => {
                "id"                              => 39,
                "name"                            => "Test_provision_7",
                "description"                     => "",
                "has_active_failures"             => true,
                "total_hosts"                     => 1,
                "hosts_with_active_failures"      => 1,
                "total_groups"                    => 0,
                "groups_with_active_failures"     => 0,
                "has_inventory_sources"           => false,
                "total_inventory_sources"         => 0,
                "inventory_sources_with_failures" => 0
              },
              "created_by"            => {
                "id"         => 1,
                "username"   => "admin",
                "first_name" => "",
                "last_name"  => ""
              },
              "recent_jobs"           => [
                {
                  "status"   => "failed",
                  "finished" => "2017-03-23T16:15:04.808Z",
                  "id"       => 530,
                  "name"     => "Test_provision"
                }
              ]
            },
            "created"               => "2017-03-23T16:14:44.524Z",
            "modified"              => "2017-03-23T16:15:04.717Z",
            "name"                  => "10.0.1.78",
            "description"           => "",
            "inventory"             => 39,
            "enabled"               => true,
            "instance_id"           => "",
            "variables"             => "",
            "has_active_failures"   => true,
            "has_inventory_sources" => false,
            "last_job"              => 530,
            "last_job_host_summary" => 286
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
