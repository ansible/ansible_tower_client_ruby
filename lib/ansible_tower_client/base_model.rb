module AnsibleTowerClient
  class BaseModel < HashModel
    attr_reader :api, :raw_hash

    def self.base_class
      superclass == AnsibleTowerClient::BaseModel ? self : superclass.base_class
    end

    def self.endpoint
      base_class.to_s.split(/::/)[1].tableize.to_s.freeze
    end

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

      @raw_hash = json_or_hash.kind_of?(Hash) ? json_or_hash : JSON.parse(json_or_hash)
      self.class.send(:id_attr, *raw_hash['related'].keys) if raw_hash.key?('related')

      super(raw_hash)
    end

    # Persist a brand new record and return a
    # representation of that object to the caller.
    # Pass in the api connection and a JSON string.
    #
    # Example:
    #    project = AnsibleTowerClient::Project.create!(connection.api, {:name => 'test'}.to_json)
    #
    #    # The values passed to create! are available in the resulting object
    #    project.name            # => 'test'
    # Errors:
    #    Any error raised by the API will be returned and logged
    #
    def self.create!(api, attributes)
      response = api.post("#{endpoint}/", attributes).body
      new(api, JSON.parse(response))
    end

    # Just like create! except a false
    #   is returned if the object is not saved.
    #
    def self.create(*args)
      create!(*args)
    rescue AnsibleTowerClient::Error
      false
    end

    # Persist changes passed in as a Hash and return a
    # representation of that object to the caller.
    #
    # Example:
    #    project = connection.api.projects.find 2
    #    project.update_attributes!(:name => 'test')
    #
    #    # The values passed to update_attributes! are available in calling object
    #    project.name            # => 'test'
    # Errors:
    #    Any error raised by the API will be returned and logged
    #
    def update_attributes!(attributes)
      @api.patch(url, attributes.to_json)
      attributes.each do |method_name, value|
        invoke_name = "#{override_raw_attributes[method_name] || method_name}="
        if respond_to?(invoke_name)
          send(invoke_name, value)
        else
          AnsibleTowerClient.logger.warn("Unknown attribute/method: #{invoke_name}. Skip updating it ...")
        end
      end
      true
    end

    # Just like update_attributes! except a true or false
    #   is returned if the object is saved or not.
    #
    def update_attributes(attributes)
      update_attributes!(attributes)
    rescue AnsibleTowerClient::Error
      false
    end

    # Persist in memory changes.
    #
    # Example:
    #    project = connection.api.projects.find 2
    #    project.name = 'test'
    #    project.save!
    #
    #    # The in memory values are persisted.
    #    project.name            # => 'test'
    # Errors:
    #    Any error raised by the API will be returned and logged
    #
    def save!
      @api.patch(url, to_h.to_json)
      true
    end

    # Just like save! except a true or false
    #   is returned if the object is saved or not.
    #
    def save
      save!
    rescue AnsibleTowerClient::Error
      false
    end

    # Delete the current object and
    #   return the original instance.
    #
    # Example
    #   project = connection.api.projects.find 2
    #   project.destroy!
    # Errors:
    #    Any error raised by the API will be returned and logged
    #
    def destroy!
      @api.delete(url)
      self
    end

    # Just like destroy! except a false
    #   is returned if the object is not deleted.
    #
    def destroy
      destroy!
    rescue AnsibleTowerClient::Error
      false
    end

    def override_raw_attributes
      {}
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
    end
  end
end
