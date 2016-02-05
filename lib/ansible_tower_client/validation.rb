module AnsibleTowerClient
  module Validation
    def validate(sym, *args, &block)
      begin
        parsed = JSON.parse(args.first)
        apply_and_return(sym, parsed, &block)
      rescue JSON::ParserError => e
        raise InvalidJson.new(e)
      end
    end

    def apply_and_return(sym, *args, &block)
      create_method(sym) { args.first }
      self.send(sym)
    end

    def create_method(name, &block)
      self.class.send(:define_method, name, &block)
    end

    def method_missing(sym, *args, &block)
      hashed = instance_variable_get("@#{sym.to_s}")
      raise NoMethodError if hashed.nil?
      validate(sym, hashed, &block)
    end
  end
end
