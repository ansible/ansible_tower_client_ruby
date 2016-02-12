module AnsibleTowerClient
  class Validation
    class << self
      def new(*args)
        vars = args.first
        raise InvalidHash.new(self, vars) unless vars.kind_of?(Hash)
        instances = superclass.each do
          vars.merge!('type' => type)
        end
        build_instance(*args, self, instances)
      end

      def each
        list = {}
        hash = yield
        hash.each_pair do |key, value|
          next if key == 'type'
          list[key] = send("validate_#{hash['type']}", value)
        end
        list
      end

      def validate_json(text)
        JSON.parse(text)
      rescue JSON::ParserError => e
        raise InvalidJSON.new(self, e)
      end

      def validate_yaml(text)
        YAML.safe_parse(text)
      rescue YAML::ParserError => e
        raise InvalidYAML.new(self, e)
      end

      private

      def build_instance(*args, klass, instances)
        obj = klass.allocate
        obj.send :initialize, *args if obj.respond_to?(:initialize)
        obj.build_attrs(instances)
      end
    end

    def build_attrs(hash)
      hash.each_pair do |k, v|
        self.class.class_eval("attr_reader k.to_sym")
        instance_variable_set("@#{k}", v)
      end
      self
    end
  end
end
