module AnsibleTowerClient
  class WorkflowJobNode < BaseModel
    def workflow_job
      api.workflow_jobs.find(workflow_job_id)
    end

    def job
      return unless job?

      if related.job.include?("/jobs/")
        api.jobs.find(job_id)
      elsif related.job.include?("/workflow_jobs/")
        api.workflow_jobs.find(job_id)
      end
    end

    # to filter out WorkflowJobNode that is inventory sync or project sync
    def job?
      return false if !respond_to?(:job_id) || job_id.nil?

      related.job.match?(/\/(jobs|workflow_jobs)\//)
    end
  end
end
