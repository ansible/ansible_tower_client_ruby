module AnsibleTowerClient
  class Collection
    attr_reader :api, :klass
    def initialize(api, klass = nil)
      @api   = api
      @klass = klass
    end

    def all
      find_all_by_url(klass.endpoint)
    end

    def find_all_by_url(url)
      Enumerator.new do |yielder|
        @collection = []
        next_page   = url

        loop do
          next_page = fetch_more_results(next_page) if @collection.empty?
          raise StopIteration if @collection.empty?
          yielder.yield(@collection.shift)
        end
      end
    end

    def find(id)
      build_object(parse_response(api.get("#{klass.endpoint}/#{id}/")))
    end

    private

    def class_from_type(type)
      api.send("#{type}_class")
    end

    def fetch_more_results(next_page)
      return if next_page.nil?
      body = parse_response(api.get(next_page))
      parse_result_set(body["results"])

      body["next"]
    end

    def parse_response(response)
      JSON.parse(response.body)
    end

    def parse_result_set(results)
      results.each { |result| @collection << build_object(result) }
    end

    def build_object(result)
      class_from_type(result["type"]).new(api, result)
    end
  end
end
