require 'faraday'

module AnsibleTowerClient
  class ResourceNotFound < Faraday::ResourceNotFound
    def initialize(klass, attrs = {})
      @klass  = klass
      @attrs  = attrs
      @key    = attrs.keys.first
      @value  = attrs[@key]
      super(issue_error)
    end

    def issue_error
      method = @key.nil? ? 'general' : @key
      send("#{method}_msg")
    end

    private

    def id_msg
      "Couldn't find #{@klass} with '#{@key}'=#{@value}"
    end

    def general_msg
      "Couldn't find #{@klass}"
    end
  end

  class Error < StandardError
    attr_reader :message
    def initialize(klass)
      @message = "Error on #{klass.class.name}: #{klass.inspect}"
      super(message)
    end
  end

  class InvalidHash < Error; end
  class InvalidJson < Error; end
end
