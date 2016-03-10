module AnsibleTowerClient
  class Collection
    attr_reader :api, :klass
    def initialize(api, klass)
      @api   = api
      @klass = klass
    end

    def all
      collection_for(api.get(klass.endpoint))
    end

    def collection_for(paginated_result)
      body = JSON.parse(paginated_result.body)
      results = body["results"]
      loop do
        break if body["next"].nil?
        body = JSON.parse(api.get(body["next"]).body)
        results += body["results"]
      end

      build_collection(results)
    end

    def find(id)
      raw_body = JSON.parse(api.get("#{klass.endpoint}/#{id}/").body)
      raise ResourceNotFound.new(self, :id => id) if raw_body['id'].nil?
      klass.new(api, raw_body)
    end

    private

    def build_collection(results)
      results.collect do |result|
        class_from_type(result["type"]).new(api, result)
      end
    end

    def class_from_type(type)
      camelized = type.split("_").collect(&:capitalize).join
      AnsibleTowerClient.const_get(camelized)
    end
  end
end
