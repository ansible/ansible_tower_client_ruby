module AnsibleTowerClient
  class Api < Connection
    attr_reader :instance
    def initialize(connection)
      @instance = connection
    end

    def hosts
      Collection.new(self, Host)
    end

    def groups
      Collection.new(self, Group)
    end

    def inventories
      Collection.new(self, Inventory)
    end

    def job_templates
      Collection.new(self, JobTemplate)
    end

    def ad_hoc_commands
      Collection.new(self, AdHocCommand)
    end

    def jobs
      Collection.new(self, Job)
    end

    def method_missing(method_name, *args, &block)
      instance.respond_to?(method_name) ? instance.send(method_name, *args, &block) : super
    end

    def respond_to_missing?(method, _include_private = false)
      instance.respond_to?(method)
    end
  end
end
