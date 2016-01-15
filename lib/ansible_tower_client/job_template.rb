module AnsibleTowerClient
  class JobTemplate
    extend Common
    attr_reader :id
    attr_reader :name
    attr_reader :raw_job_template_body

    def initialize(raw_job_template)
      @id   = raw_job_template["id"]
      @name = raw_job_template["name"]
      @raw_job_template_body = raw_job_template
    end
  end
end

