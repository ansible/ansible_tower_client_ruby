module AnsibleTowerClient
  module ValidJSON
    def validate(*args)
      begin
        JSON.parse(args.first)
      rescue JSON::ParserError => e
        raise InvalidJson.new(e)
      end
    end
  end
end

