module AnsibleTowerClient
  class Error < Exception; end
  class ClientError < Error; end
  class ConnectionError < Error; end
  class NoMethodError < Error; end
  class UnlicensedFeatureError < Error; end
end
