module AnsibleTowerClient
  class ProjectUpdate < BaseModel
    def stdout(format = 'txt')
      api.get("#{related['stdout']}?format=#{format}").body
    end
    alias result_stdout stdout
  end
end
