module AnsibleTowerClient
  class MockApi
    module WorkflowJobNode
      def self.collection
        [
          {
            "id": 1,
            "type": "workflow_job_node",
            "url": "/api/v1/workflow_job_nodes/2/",
            "related": {
              "unified_job_template": "/api/v1/job_templates/216/",
              "success_nodes": "/api/v1/workflow_job_nodes/1/success_nodes/",
              "failure_nodes": "/api/v1/workflow_job_nodes/1/failure_nodes/",
              "always_nodes": "/api/v1/workflow_job_nodes/1/always_nodes/",
              "workflow_job": "/api/v1/workflow_jobs/428/"
            },
            "summary_fields": {
              "workflow_job": {
                "id": 428,
                "name": "james-wf2",
                "description": ""
              },
              "unified_job_template": {
                "id": 216,
                "name": "Demo Job Template",
                "description": "",
                "unified_job_type": "job"
              }
            },
            "created": "2018-05-17T13:13:48.022Z",
            "modified": "2018-05-17T13:13:51.562Z",
            "unified_job_template": 216,
            "success_nodes": [],
            "failure_nodes": [],
            "always_nodes": [
                2
            ],
            "inventory": nil,
            "credential": nil,
            "job_type": nil,
            "job_tags": nil,
            "skip_tags": nil,
            "limit": nil,
            "workflow_job": 428
          },
          {
            "id": 2,
            "type": "workflow_job_node",
            "url": "/api/v1/workflow_job_nodes/1/",
            "related": {
              "unified_job_template": "/api/v1/job_templates/216/",
              "success_nodes": "/api/v1/workflow_job_nodes/1/success_nodes/",
              "failure_nodes": "/api/v1/workflow_job_nodes/1/failure_nodes/",
              "always_nodes": "/api/v1/workflow_job_nodes/1/always_nodes/",
              "job": "/api/v1/jobs/429/",
              "workflow_job": "/api/v1/workflow_jobs/428/"
            },
            "summary_fields": {
              "workflow_job": {
                "id": 428,
                "name": "james-wf2",
                "description": ""
              },
              "job": {
                "id": 429,
                "name": "Demo Job Template",
                "description": "",
                "status": "successful",
                "failed": false,
                "elapsed": 6.344
              },
              "unified_job_template": {
                "id": 216,
                "name": "Demo Job Template",
                "description": "",
                "unified_job_type": "job"
              }
            },
            "created": "2018-05-17T13:13:48.022Z",
            "modified": "2018-05-17T13:13:51.562Z",
            "unified_job_template": 216,
            "success_nodes": [],
            "failure_nodes": [],
            "always_nodes": [
                2
            ],
            "inventory": nil,
            "credential": nil,
            "job_type": nil,
            "job_tags": nil,
            "skip_tags": nil,
            "limit": nil,
            "job": 429,
            "workflow_job": 428
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
