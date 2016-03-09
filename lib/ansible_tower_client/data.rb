module AnsibleTowerClient
  class Data
    attr_reader :items
    def initialize(in_hash)
      @items = {}
      validate(in_hash)
    end

    def self.validate!(hash)
      raise InvalidHash.new(hash) unless hash.kind_of?(Hash)
      new(hash).items
    end

    def to_tower_hash(tower_key, value)
      @items[tower_key.to_s] = value.to_json
    end

    def validate(hash)
      hash.each do |k, v|
        begin
          to_tower_hash(k, YAML.safe_load(v))
        rescue JSON::ParserError => e
          raise InvalidJson.new(e)
        rescue TypeError => e
          raise InvalidYaml.new(e)
        end
      end
    end
  end
end
