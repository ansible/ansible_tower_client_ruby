module AnsibleTowerClient
  module CollectionMethods
    def all
      body = JSON.parse(Api.get(endpoint).body)
      results = body["results"]
      loop do
        break if body["next"].nil?
        body = JSON.parse(Api.get(body["next"]).body)
        results += body["results"]
      end

      build_collection(results)
    end

    def find(id)
      body = JSON.parse(Api.get("#{endpoint}/#{id}/").body)
      raise ResourceNotFound.new(self, :id => id) if body['id'].nil?
      new(body)
    end

    private

    def build_collection(results)
      results.collect do |result|
        klass = class_from_type(result["type"])
        klass.new(result)
      end
    end

    def class_from_type(type)
      camelized = type.split("_").collect(&:capitalize).join
      AnsibleTowerClient.const_get(camelized)
    end
  end
end

