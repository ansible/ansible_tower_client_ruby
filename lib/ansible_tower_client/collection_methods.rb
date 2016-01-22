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

      results.collect { |raw| new(raw) }
    end

    def find(id)
      body = JSON.parse(Api.get("#{endpoint}/#{id}/").body)
      raise NoMethodError if body['id'].nil?
      new(body)
    end
  end
end

