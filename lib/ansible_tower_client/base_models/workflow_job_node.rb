module AnsibleTowerClient
  class WorkflowJobNode < BaseModel
    def workflow_job
      api.workflow_jobs.find(self.workflow_job_id)
    end
    def job
      self.job_id.nil? ? nil : api.jobs.find(self.job_id)
    end
  end
end
