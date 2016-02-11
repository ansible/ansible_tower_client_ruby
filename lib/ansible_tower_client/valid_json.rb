module AnsibleTowerClient
  module ValidJSON
    def validate(text)
      begin
        JSON.parse(text)
      rescue JSON::ParserError => e
        raise InvalidJson.new(e)
      end
    end
  end
end

