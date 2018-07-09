module AnsibleTowerClient
  class WorkflowJobNode < BaseModel
    def workflow_job
      api.workflow_jobs.find(workflow_job_id)
    end

    def job
      super.nil? ? nil : api.jobs.find(job_id)
    end
  end
end
