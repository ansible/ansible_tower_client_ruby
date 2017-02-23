module AnsibleTowerClient
  class Error         < StandardError; end
  class ClientError   < Error; end
  class NoMethodError < Error; end

  class ConnectionError        < ClientError; end
  class ResourceNotFoundError  < ClientError; end
  class SSLError               < ClientError; end
  class UnlicensedFeatureError < ClientError; end
end
