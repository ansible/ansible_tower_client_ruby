module AnsibleTowerClient
  class WorkflowJobNode < BaseModel
    def workflow_job
      api.workflow_jobs.find(workflow_job_id)
    end

    def job
      api.jobs.find(job_id) if respond_to?(:job_id) && !job_id.to_s.strip.empty?
    end
  end
end
