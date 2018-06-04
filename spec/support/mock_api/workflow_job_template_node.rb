module AnsibleTowerClient
  class MockApi
    module WorkflowJobTemplateNode
      def self.collection
        [
          {
            "id": 1,
            "type": "workflow_job_template_node",
            "url": "/api/v1/workflow_job_template_nodes/1/",
            "related": {
              "unified_job_template": "/api/v1/job_templates/216/",
              "success_nodes": "/api/v1/workflow_job_template_nodes/1/success_nodes/",
              "failure_nodes": "/api/v1/workflow_job_template_nodes/1/failure_nodes/",
              "always_nodes": "/api/v1/workflow_job_template_nodes/1/always_nodes/",
              "workflow_job_template": "/api/v1/workflow_job_templates/298/"
            },
            "summary_fields": {
              "workflow_job_template": {
                "id": 298,
                "name": "james-wf",
                "description": ""
              },
              "unified_job_template": {
                "id": 216,
                "name": "Demo Job Template",
                "description": "",
                "unified_job_type": "job"
              }
            },
            "created": "2018-05-14T04:29:17.104Z",
            "modified": "2018-05-14T04:29:17.104Z",
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
            "workflow_job_template": 298
          },
          {
            "id": 4,
            "type": "workflow_job_template_node",
            "url": "/api/v1/workflow_job_template_nodes/4/",
            "related": {
              "unified_job_template": "/api/v1/job_templates/216/",
              "success_nodes": "/api/v1/workflow_job_template_nodes/4/success_nodes/",
              "failure_nodes": "/api/v1/workflow_job_template_nodes/4/failure_nodes/",
              "always_nodes": "/api/v1/workflow_job_template_nodes/4/always_nodes/",
              "workflow_job_template": "/api/v1/workflow_job_templates/299/"
            },
            "summary_fields": {
              "workflow_job_template": {
                "id": 299,
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
            "created": "2018-05-14T04:33:55.065Z",
            "modified": "2018-05-14T04:33:55.066Z",
            "unified_job_template": 216,
            "success_nodes": [],
            "failure_nodes": [],
            "always_nodes": [
              5
            ],
            "inventory": nil,
            "credential": nil,
            "job_type": nil,
            "job_tags": nil,
            "skip_tags": nil,
            "limit": nil,
            "workflow_job_template": 299
          },
          {
            "id": 7,
            "type": "workflow_job_template_node",
            "url": "/api/v1/workflow_job_template_nodes/7/",
            "related": {
              "unified_job_template": "/api/v1/job_templates/342/",
              "success_nodes": "/api/v1/workflow_job_template_nodes/7/success_nodes/",
              "failure_nodes": "/api/v1/workflow_job_template_nodes/7/failure_nodes/",
              "always_nodes": "/api/v1/workflow_job_template_nodes/7/always_nodes/",
              "workflow_job_template": "/api/v1/workflow_job_templates/298/"
            },
            "summary_fields": {
              "workflow_job_template": {
                "id": 298,
                "name": "james-wf",
                "description": ""
              },
              "unified_job_template": {
                "id": 342,
                "name": "hello_template_with_survey",
                "description": "test job with survey spec",
                "unified_job_type": "job"
              }
            },
            "created": "2018-05-29T19:30:05.275Z",
            "modified": "2018-05-29T19:30:05.275Z",
            "unified_job_template": 342,
            "success_nodes": [],
            "failure_nodes": [],
            "always_nodes": [],
            "inventory": nil,
            "credential": nil,
            "job_type": nil,
            "job_tags": nil,
            "skip_tags": nil,
            "limit": nil,
            "workflow_job_template": 298
          },
          {
            "id": 2,
            "type": "workflow_job_template_node",
            "url": "/api/v1/workflow_job_template_nodes/2/",
            "related": {
              "unified_job_template": "/api/v1/job_templates/262/",
              "success_nodes": "/api/v1/workflow_job_template_nodes/2/success_nodes/",
              "failure_nodes": "/api/v1/workflow_job_template_nodes/2/failure_nodes/",
              "always_nodes": "/api/v1/workflow_job_template_nodes/2/always_nodes/",
              "workflow_job_template": "/api/v1/workflow_job_templates/298/"
            },
            "summary_fields": {
              "workflow_job_template": {
                "id": 298,
                "name": "james-wf",
                "description": ""
              },
              "unified_job_template": {
                "id": 262,
                "name": "billy",
                "description": "billy",
                "unified_job_type": "job"
              }
            },
            "created": "2018-05-14T04:29:17.318Z",
            "modified": "2018-05-29T19:30:05.398Z",
            "unified_job_template": 262,
            "success_nodes": [
              7
            ],
            "failure_nodes": [
              3
            ],
            "always_nodes": [],
            "inventory": nil,
            "credential": nil,
            "job_type": nil,
            "job_tags": nil,
            "skip_tags": nil,
            "limit": nil,
            "workflow_job_template": 298
          },
          {
            "id": 6,
            "type": "workflow_job_template_node",
            "url": "/api/v1/workflow_job_template_nodes/6/",
            "related": {
              "unified_job_template": "/api/v1/job_templates/341/",
              "success_nodes": "/api/v1/workflow_job_template_nodes/6/success_nodes/",
              "failure_nodes": "/api/v1/workflow_job_template_nodes/6/failure_nodes/",
              "always_nodes": "/api/v1/workflow_job_template_nodes/6/always_nodes/",
              "workflow_job_template": "/api/v1/workflow_job_templates/299/"
            },
            "summary_fields": {
              "workflow_job_template": {
                "id": 299,
                "name": "james-wf2",
                "description": ""
              },
              "unified_job_template": {
                "id": 341,
                "name": "hello_template",
                "description": "test job",
                "unified_job_type": "job"
              }
            },
            "created": "2018-05-14T04:33:55.089Z",
            "modified": "2018-05-29T19:30:53.111Z",
            "unified_job_template": 341,
            "success_nodes": [],
            "failure_nodes": [],
            "always_nodes": [],
            "inventory": nil,
            "credential": nil,
            "job_type": nil,
            "job_tags": nil,
            "skip_tags": nil,
            "limit": nil,
            "workflow_job_template": 299
          },
          {
            "id": 5,
            "type": "workflow_job_template_node",
            "url": "/api/v1/workflow_job_template_nodes/5/",
            "related": {
              "unified_job_template": "/api/v1/job_templates/262/",
              "success_nodes": "/api/v1/workflow_job_template_nodes/5/success_nodes/",
              "failure_nodes": "/api/v1/workflow_job_template_nodes/5/failure_nodes/",
              "always_nodes": "/api/v1/workflow_job_template_nodes/5/always_nodes/",
              "workflow_job_template": "/api/v1/workflow_job_templates/299/"
            },
            "summary_fields": {
              "workflow_job_template": {
                "id": 299,
                "name": "james-wf2",
                "description": ""
              },
              "unified_job_template": {
                "id": 262,
                "name": "billy",
                "description": "billy",
                "unified_job_type": "job"
              }
            },
            "created": "2018-05-14T04:33:55.077Z",
            "modified": "2018-05-29T19:30:53.119Z",
            "unified_job_template": 262,
            "success_nodes": [],
            "failure_nodes": [
              6
            ],
            "always_nodes": [],
            "inventory": nil,
            "credential": nil,
            "job_type": nil,
            "job_tags": nil,
            "skip_tags": nil,
            "limit": nil,
            "workflow_job_template": 299
          },
          {
            "id": 3,
            "type": "workflow_job_template_node",
            "url": "/api/v1/workflow_job_template_nodes/3/",
            "related": {
              "unified_job_template": "/api/v1/job_templates/341/",
              "success_nodes": "/api/v1/workflow_job_template_nodes/3/success_nodes/",
              "failure_nodes": "/api/v1/workflow_job_template_nodes/3/failure_nodes/",
              "always_nodes": "/api/v1/workflow_job_template_nodes/3/always_nodes/",
              "workflow_job_template": "/api/v1/workflow_job_templates/298/"
            },
            "summary_fields": {
              "workflow_job_template": {
                "id": 298,
                "name": "james-wf",
                "description": ""
              },
              "unified_job_template": {
                "id": 341,
                "name": "hello_template",
                "description": "test job",
                "unified_job_type": "job"
              }
            },
            "created": "2018-05-14T04:29:17.426Z",
            "modified": "2018-06-01T20:59:26.451Z",
            "unified_job_template": 341,
            "success_nodes": [],
            "failure_nodes": [],
            "always_nodes": [],
            "inventory": nil,
            "credential": nil,
            "job_type": nil,
            "job_tags": nil,
            "skip_tags": nil,
            "limit": nil,
            "workflow_job_template": 298
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
