module AnsibleTowerClient
  class BaseModel < HashModel
    attr_reader :api

    # Constructs and returns a new JSON wrapper class. Pass in a plain
    # JSON string and it will automatically give you accessor methods
    # that make it behave like a typical Ruby object. You may also pass
    # in a hash.
    #
    # Example:
    #   class Person < AnsibleTowerClient::BaseModel; end
    #
    #   json_string = '{"firstname":"jeff", "lastname":"durand",
    #     "address": { "street":"22 charlotte rd", "zipcode":"01013"}
    #   }'
    #
    #   # Or whatever your subclass happens to be.
    #   person = Person.new(api, json_string)
    #
    #   # The JSON properties are now available as methods.
    #   person.firstname        # => 'jeff'
    #   person.address.zipcode  # => '01013'
    #
    #   # Or you can get back the original JSON if necessary.
    #   person.to_json # => Returns original JSON
    #
    def initialize(api, json_or_hash)
      @api = api

      raw_hash = json_or_hash.kind_of?(Hash) ? json_or_hash : JSON.parse(json_or_hash)
      self.class.send(:id_attr, *raw_hash['related'].keys) if raw_hash.key?('related')

      super(raw_hash)
    end

    def hashify(attribute)
      YAML.safe_load(send(attribute))
    end

    private

    # convert a hash to an instance of nested model class
    def hash_to_model(klass_name, hash)
      model_klass =
        if self.class.const_defined?(klass_name, false)
          self.class.const_get(klass_name)
        else
          self.class.const_set(klass_name, Class.new(BaseModel))
        end
      model_klass.new(api, hash)
    end

    class << self
      private

      def id_attrs
        @id_attrs || Set.new
      end

      # Selected attributes should be treated as ids, so '_id' will be appended
      def id_attr(*attrs)
        @id_attrs = id_attrs | Set.new(attrs.collect(&:to_s))
      end

      def key_to_attribute(key)
        key = key.to_s
        key = "#{key}_id" if !key.end_with?('_id') && id_attrs.include?(key)
        key.underscore
      end

      def generate_writer?
        false
      end
    end
  end
end
