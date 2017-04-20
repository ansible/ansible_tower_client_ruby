module AnsibleTowerClient
  class MockApi
    module Job
      def self.collection
        [
          {
            "id"                        => 103,
            "type"                      => "job",
            "url"                       => "/api/v1/jobs/103/",
            "related"                   => {
              "created_by"           => "/api/v1/users/1/",
              "labels"               => "/api/v1/jobs/103/labels/",
              "inventory"            => "/api/v1/inventories/1/",
              "project"              => "/api/v1/projects/4/",
              "credential"           => "/api/v1/credentials/1/",
              "unified_job_template" => "/api/v1/job_templates/30/",
              "stdout"               => "/api/v1/jobs/103/stdout/",
              "job_host_summaries"   => "/api/v1/jobs/103/job_host_summaries/",
              "job_tasks"            => "/api/v1/jobs/103/job_tasks/",
              "job_plays"            => "/api/v1/jobs/103/job_plays/",
              "job_events"           => "/api/v1/jobs/103/job_events/",
              "notifications"        => "/api/v1/jobs/103/notifications/",
              "activity_stream"      => "/api/v1/jobs/103/activity_stream/",
              "job_template"         => "/api/v1/job_templates/30/",
              "start"                => "/api/v1/jobs/103/start/",
              "cancel"               => "/api/v1/jobs/103/cancel/",
              "relaunch"             => "/api/v1/jobs/103/relaunch/"
            },
            "summary_fields"            => {
              "job_template"         => {
                "id"          => 30,
                "name"        => "bd-test",
                "description" => ""
              },
              "inventory"            => {
                "id"                              => 1,
                "name"                            => "Demo Inventory",
                "description"                     => "",
                "has_active_failures"             => false,
                "total_hosts"                     => 2,
                "hosts_with_active_failures"      => 0,
                "total_groups"                    => 0,
                "groups_with_active_failures"     => 0,
                "has_inventory_sources"           => false,
                "total_inventory_sources"         => 0,
                "inventory_sources_with_failures" => 0
              },
              "credential"           => {
                "id"          => 1,
                "name"        => "Demo Credential",
                "description" => "",
                "kind"        => "ssh",
                "cloud"       => false
              },
              "unified_job_template" => {
                "id"               => 30,
                "name"             => "bd-test",
                "description"      => "",
                "unified_job_type" => "job"
              },
              "project"              => {
                "id"          => 4,
                "name"        => "Demo Project",
                "description" => "A great demo",
                "status"      => "successful"
              },
              "created_by"           => {
                "id"         => 1,
                "username"   => "admin",
                "first_name" => "",
                "last_name"  => ""
              },
              "labels"               => {
                "count"   => 0,
                "results" => []
              }
            },
            "created"                   => "2017-02-06T15:06:53.338Z",
            "modified"                  => "2017-02-06T15:07:03.883Z",
            "name"                      => "bd-test",
            "description"               => "",
            "unified_job_template"      => 30,
            "launch_type"               => "manual",
            "status"                    => "successful",
            "failed"                    => false,
            "started"                   => "2017-02-06T15:07:16.022594Z",
            "finished"                  => "2017-02-06T15:07:19.588779Z",
            "elapsed"                   => 3.566,
            "job_explanation"           => "",
            "job_type"                  => "run",
            "inventory"                 => 1,
            "project"                   => 4,
            "playbook"                  => "hello_world.yml",
            "credential"                => 1,
            "cloud_credential"          => nil,
            "network_credential"        => nil,
            "forks"                     => 0,
            "limit"                     => "",
            "verbosity"                 => 0,
            "extra_vars"                => "{}",
            "job_tags"                  => "",
            "force_handlers"            => false,
            "skip_tags"                 => "",
            "start_at_task"             => "",
            "job_template"              => 30,
            "passwords_needed_to_start" => [],
            "ask_variables_on_launch"   => false,
            "ask_limit_on_launch"       => false,
            "ask_tags_on_launch"        => false,
            "ask_job_type_on_launch"    => false,
            "ask_inventory_on_launch"   => false,
            "ask_credential_on_launch"  => false
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
