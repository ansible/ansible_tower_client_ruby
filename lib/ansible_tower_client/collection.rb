module AnsibleTowerClient
  class Collection
    attr_reader :api, :klass
    def initialize(api, klass = nil)
      @api   = api
      @klass = klass
    end

    # @param get_options [Hash] a hash of http GET params to pass to the api request
    #   e.g. { :order_by => 'timestamp', :name__contains => 'foo' }
    def all(get_options = nil)
      find_all_by_url(klass.endpoint, get_options)
    end

    def find_all_by_url(url, get_options = nil)
      Enumerator.new do |yielder|
        @collection = []
        next_page   = url

        loop do
          next_page = fetch_more_results(next_page, get_options) if @collection.empty?
          get_options = nil
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

    def fetch_more_results(next_page, get_options)
      return if next_page.nil?
      body = parse_response(api.get(next_page, get_options))
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
