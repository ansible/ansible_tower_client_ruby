module AnsibleTowerClient
  # A core base class for JSON wrapper classes. The original data can be a JSON
  # string or a hash parsed from JSON string. Similar to OpenStruct, it auto
  # generates access methods base on key names. If the value is also a hash,
  # it too gets converted to an instance of model class.
  #
  # This is an abstract class.
  class HashModel
    class << self
      private

      # Convert a key to a model class attribute which must be a qualified ruby method name
      # key is from the original JSON or Hash object
      #
      # This is the default implementation, to be overridden by subclasses.
      #
      def key_to_attribute(key)
        key.to_s.underscore
      end

      # Should setter methods be automatically created?
      #
      # Default to true, to be overridden by subclasses.
      #
      def generate_writer?
        true
      end

      # Should values of this attribute be excluded from converting to model objects
      #
      # Default to false, to be overridden by subclasses.
      #
      def attr_excluded?(_attr_name)
        false
      end

      # Declare attributes that need to be converted to Model
      def attr_model(*attrs)
        # Merge the declared attributes to the modelized list
        @modelized_list = modelized_list | Set.new(attrs.map(&:to_s))
      end

      # Return the list of modelized attributes
      def modelized_list
        @modelized_list ||= Set.new
      end

      def convert_value(key, value, parent)
        method = key_to_attribute(key).gsub(/\W/, '_') # replace all unqualified characters for method and class names

        new_val =
          if attr_excluded?(method)
            value
          else
            # Must deal with nested models
            case value
            when Array
              value.collect do |elem|
                elem.kind_of?(Hash) ? parent.send(:hash_to_model, method.camelize.singularize, elem) : elem
              end
            when Hash
              parent.send(:hash_to_model, method.camelize, value)
            else
              value
            end
          end

        add_accessor_methods(method, key)
        new_val
      end

      def add_accessor_methods(method, key)
        return if modelized_list.include?(method.to_s)

        method = "_#{method}" if instance_methods.include?(method.to_sym)
        class_eval { define_method(method) { @data[key] } }
        attr_model(method)

        return unless generate_writer?
        class_eval { define_method("#{method}=") { |val| @data[key] = val } }
      end
    end

    def initialize(json_or_hash)
      raw_hash = json_or_hash.kind_of?(Hash) ? json_or_hash : JSON.parse(json_or_hash)
      @data = Hash[raw_hash.collect { |key, value| [key, self.class.send(:convert_value, key, value, self)] }]
    end

    def [](key)
      @data[key]
    end

    def to_h
      Hash[@data.collect { |key, value| [key, value_to_hash(value)] }]
    end

    alias_method :to_hash, :to_h

    def to_json
      to_h.to_json
    end

    alias_method :to_s, :to_json

    def inspect
      string = "<#{self.class} "
      string << @data.collect { |key, value| "#{self.class.send(:key_to_attribute, key)}=#{value.inspect}" }.join(", ")
      string << ">"
    end

    def ==(other)
      return false unless other.kind_of?(HashModel)
      to_h == other.to_h
    end

    alias_method :eql?, :==

    private

    def value_to_hash(value)
      case value
      when HashModel, Hash then value.to_h
      when Array           then value.collect { |elem| elem.kind_of?(HashModel) ? elem.to_h : elem }
      else                      value
      end
    end

    # Convert a hash to an instance of nested model class
    #
    # This is the default implementation; the resulting object is based on HashModel
    # To be overridden by subclasses
    #
    def hash_to_model(klass_name, hash)
      model_klass =
        if self.class.const_defined?("#{self.class}::#{klass_name}")
          self.class.const_get(klass_name)
        else
          self.class.const_set(klass_name, Class.new(HashModel))
        end
      model_klass.new(hash)
    end
  end
end
