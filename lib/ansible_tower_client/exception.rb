module AnsibleTowerClient
  class Error < Exception; end
  class ConnectionError < Error; end
  class NoMethodError < Error; end
  class ClientError < Error; end
end
