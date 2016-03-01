require 'securerandom'

module AnsibleTowerClient
  module FactoryHelper
    def self.stringify_attribute_keys(hash)
      [:description, :extra_vars, :id, :instance_id, :inventory, :name, :results,
       :type, :url, :related].each do |attribute|
        val = hash.delete(attribute)
        hash[attribute.to_s] = val if val
      end
      hash.delete(:klass)
      hash
    end

    def self.underscore_string(string)
      string.gsub(/([a-z\d])([A-Z])/, '\1_\2').downcase
    end
  end
end
