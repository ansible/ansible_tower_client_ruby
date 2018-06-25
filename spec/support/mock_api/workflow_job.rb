module AnsibleTowerClient
  class MockApi
    module WorkflowJob
      def self.collection
        [
          {
            "id": 792,
            "type": "workflow_job",
            "url": "/api/v1/workflow_jobs/792/",
            "related": {
            "created_by": "/api/v1/users/1/",
            "unified_job_template": "/api/v1/workflow_job_templates/345/",
            "workflow_job_template": "/api/v1/workflow_job_templates/345/",
            "notifications": "/api/v1/workflow_jobs/792/notifications/",
            "workflow_nodes": "/api/v1/workflow_jobs/792/workflow_nodes/",
            "labels": "/api/v1/workflow_jobs/792/labels/",
            "activity_stream": "/api/v1/workflow_jobs/792/activity_stream/",
            "relaunch": "/api/v1/workflow_jobs/792/relaunch/",
            "cancel": "/api/v1/workflow_jobs/792/cancel/"
          },
            "summary_fields": {
            "instance_group": {
            "id": 1,
            "name": "tower"
          },
            "workflow_job_template": {
            "id": 345,
            "name": "Demo-workflow (a expln)",
            "description": ""
          },
            "unified_job_template": {
            "id": 345,
            "name": "Demo-workflow (a expln)",
            "description": "",
            "unified_job_type": "workflow_job"
          },
            "created_by": {
            "id": 1,
            "username": "admin",
            "first_name": "",
            "last_name": ""
          },
            "user_capabilities": {
            "start": true,
          "delete": true
          },
            "labels": {
            "count": 0,
            "results": []
          }
          },
            "created": "2018-06-20T20:01:10.696Z",
            "modified": "2018-06-20T20:01:32.763Z",
            "name": "Demo-workflow (a expln)",
            "description": "",
            "unified_job_template": 345,
            "launch_type": "relaunch",
            "status": "successful",
            "failed": false,
          "started": "2018-06-20T20:01:10.873367Z",
            "finished": "2018-06-20T20:01:32.758097Z",
            "elapsed": 21.885,
            "job_args": "",
            "job_cwd": "",
            "job_env": {},
            "job_explanation": "",
            "result_stdout": "stdout capture is missing",
            "result_traceback": "",
            "workflow_job_template": 345,
            "extra_vars": "{\"colors\": [\"red\", \"blue\"], \"name\": \"test abc\"}",
            "allow_simultaneous": false
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
