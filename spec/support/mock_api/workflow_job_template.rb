module AnsibleTowerClient
  class MockApi
    module WorkflowJobTemplate
      def self.collection
        [
          {
            "id"                       => 108,
            "type"                     => "workflow_job_template",
            "url"                      => "/api/v1/workflow_job_templates/108/",
            "related"                  => {
              "created_by"                     => "/api/v1/users/1/",
              "labels"                         => "/api/v1/workflow_job_templates/108/labels/",
              "inventory"                      => "/api/v1/inventories/8/",
              "project"                        => "/api/v1/projects/37/",
              "credential"                     => "/api/v1/credentials/1/",
              "last_job"                       => "/api/v1/jobs/140/",
              "notification_templates_error"   => "/api/v1/workflow_job_template/108/notification_templates_error/",
              "notification_templates_success" => "/api/v1/workflow_job_template/108/notification_templates_success/",
              "jobs"                           => "/api/v1/workflow_job_template/108/jobs/",
              "object_roles"                   => "/api/v1/workflow_job_template/108/object_roles/",
              "notification_templates_any"     => "/api/v1/workflow_job_template/108/notification_templates_any/",
              "access_list"                    => "/api/v1/workflow_job_template/108/access_list/",
              "launch"                         => "/api/v1/workflow_job_template/108/launch/",
              "schedules"                      => "/api/v1/workflow_job_template/108/schedules/",
              "activity_stream"                => "/api/v1/workflow_job_template/108/activity_stream/",
              "survey_spec"                    => "/api/v1/workflow_job_template/108/survey_spec/"
            },
            "summary_fields"           => {
              "last_job"     => {
                "id"          => 140,
                "name"        => "421_playbook-service-demo_provision",
                "description" => "this is a test",
                "finished"    => "2017-02-16T21:45:28.115Z",
                "status"      => "successful",
                "failed"      => false
              },
              "last_update"  => {
                "id"          => 140,
                "name"        => "421_playbook-service-demo_provision",
                "description" => "this is a test",
                "status"      => "successful",
                "failed"      => false
              },
              "inventory"    => {
                "id"                              => 8,
                "name"                            => "miq-default",
                "description"                     => "default inventory",
                "has_active_failures"             => false,
                "total_hosts"                     => 2,
                "hosts_with_active_failures"      => 0,
                "total_groups"                    => 0,
                "groups_with_active_failures"     => 0,
                "has_inventory_sources"           => false,
                "total_inventory_sources"         => 0,
                "inventory_sources_with_failures" => 0
              },
              "credential"   => {
                "id"          => 1,
                "name"        => "Demo Credential",
                "description" => "",
                "kind"        => "ssh",
                "cloud"       => false
              },
              "project"      => {
                "id"          => 37,
                "name"        => "Test Project",
                "description" => "",
                "status"      => "successful"
              },
              "created_by"   => {
                "id"         => 1,
                "username"   => "admin",
                "first_name" => "",
                "last_name"  => ""
              },
              "object_roles" => {
                "admin_role"   => {
                  "description" => "Can manage all aspects of the job template",
                  "id"          => 325,
                  "name"        => "Admin"
                },
                "execute_role" => {
                  "description" => "May run the job template",
                  "id"          => 327,
                  "name"        => "Execute"
                },
                "read_role"    => {
                  "description" => "May view settings for the job template",
                  "id"          => 326,
                  "name"        => "Read"
                }
              },
              "labels"       => {
                "count"   => 0,
                "results" => []
              },
              "can_copy"     => true,
              "can_edit"     => true,
              "recent_jobs"  => [
                {
                  "status"   => "successful",
                  "finished" => "2017-02-16T21:45:28.115Z",
                  "id"       => 140
                },
                {
                  "status"   => "failed",
                  "finished" => "2017-02-16T21:23:55.950Z",
                  "id"       => 138
                },
                {
                  "status"   => "successful",
                  "finished" => "2017-02-16T21:20:20.336Z",
                  "id"       => 136
                },
                {
                  "status"   => "failed",
                  "finished" => "2017-02-16T21:14:39.976Z",
                  "id"       => 133
                },
                {
                  "status"   => "successful",
                  "finished" => "2017-02-11T18:29:47.257Z",
                  "id"       => 110
                }
              ]
            },
            "created"                  => "2017-02-11T18:13:49.720Z",
            "modified"                 => "2017-02-16T21:45:12.197Z",
            "name"                     => "421_playbook-service-demo_provision",
            "description"              => "this is a test",
            "job_type"                 => "run",
            "inventory"                => 8,
            "project"                  => 37,
            "playbook"                 => "hello_world.yml",
            "credential"               => 1,
            "cloud_credential"         => nil,
            "network_credential"       => nil,
            "forks"                    => 0,
            "limit"                    => "",
            "verbosity"                => 3,
            "extra_vars"               => {"option" => "lots_of_options"}.to_json,
            "job_tags"                 => "",
            "force_handlers"           => false,
            "skip_tags"                => "",
            "start_at_task"            => "",
            "last_job_run"             => "2017-02-16T21:45:28.115918Z",
            "last_job_failed"          => false,
            "has_schedules"            => false,
            "next_job_run"             => nil,
            "status"                   => "successful",
            "host_config_key"          => "",
            "ask_variables_on_launch"  => true,
            "ask_limit_on_launch"      => true,
            "ask_tags_on_launch"       => false,
            "ask_job_type_on_launch"   => false,
            "ask_inventory_on_launch"  => true,
            "ask_credential_on_launch" => true,
            "survey_enabled"           => false,
            "become_enabled"           => false,
            "allow_simultaneous"       => false
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
