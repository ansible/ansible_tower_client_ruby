module AnsibleTowerClient
  class WorkflowJobNode < BaseModel
    def workflow_job
      api.workflow_jobs.find(workflow_job_id)
    end

    def job
      api.jobs.find(job_id) if job?
    end

    # to filter out WorkflowJobNode that is inventory sync or project sync
    def job?
      return false if !respond_to?(:job_id) || job_id.nil?

      related.job.match?(/jobs/)
    end
  end
end
