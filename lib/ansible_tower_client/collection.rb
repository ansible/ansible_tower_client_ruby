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
      find_all_by_url("#{klass.endpoint}/", get_options)
    end

    def find_all_by_url(url, get_options = nil)
      Enumerator.new do |yielder|
        @collection = []
        next_page   = url
        options     = get_options

        loop do
          next_page = fetch_more_results(next_page, options) if @collection.empty?
          options = nil
          raise StopIteration if @collection.empty?
          yielder.yield(@collection.shift)
        end
      end
    end

    def find(id)
      build_object(parse_response(api.get(find_uri(id))))
    end

    def create!(*args)
      klass.create!(api, *args)
    end

    def create(*args)
      klass.create(api, *args)
    end

    private

    def class_from_type(type)
      api.send("#{type}_class")
    end

    def fetch_more_results(next_page, get_options)
      return if next_page.nil?
      body = parse_response(api.get(next_page, get_options))
      parse_result_set(body)
    end

    def find_uri(id)
      File.join(klass.endpoint, id.to_s, "/")
    end

    def parse_response(response)
      JSON.parse(response.body)
    end

    def parse_result_set(body)
      case body.class.name
      when "Array" then
        @collection = body
        nil
      when "Hash" then
        body["results"].each { |result| @collection << build_object(result) }
        body["next"]
      end
    end

    def build_object(result)
      (klass || class_from_type(result['type'])).new(api, result)
    end
  end
end
