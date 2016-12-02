require 'logger'

module AnsibleTowerClient
  class NullLogger < Logger
    def initialize(*_args)
    end

    def add(*_args, &_block)
    end

    def debug?
      false
    end
  end
end
