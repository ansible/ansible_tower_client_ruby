module AnsibleTowerClient
  class WorkflowJob < BaseModel
    def workflow_job_nodes
      # this is where Ansible API deviates from other part by using `workflow_nodes`
      Collection.new(api).find_all_by_url(related['workflow_nodes'])
    end

    def extra_vars_hash
      extra_vars.empty? ? {} : hashify(:extra_vars)
    end
  end
end
