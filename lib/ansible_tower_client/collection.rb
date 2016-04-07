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
      body = YAML.safe_load(paginated_result.body)
      results = body["results"]
      loop do
        break if body["next"].nil?
        body = YAML.safe_load(api.get(body["next"]).body)
        results += body["results"]
      end

      build_collection(hashify(results))
    end

    def find(id)
      raw_body = YAML.safe_load(api.get("#{klass.endpoint}/#{id}/").body)
      results = hashify([raw_body]).first
      klass.new(api, results)
    end

    private

    def hashify(results)
      excluded = klass.const_get("EXCLUDED").map!(&:to_s)
      return results if excluded.empty?
      excluded.each do |attr|
        results.each { |result| result[attr] = YAML.safe_load(result[attr]) unless result[attr].nil? }
      end
      results
    end

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
