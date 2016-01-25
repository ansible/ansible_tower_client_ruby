module AnsibleTowerClient
  class Api
    private_class_method :new

    def self.instance(options = nil)
      @instance ||= begin
        require 'faraday'
        require 'faraday_middleware'
        Faraday.new(options[:base_url], :ssl => {:verify => options[:verify_ssl]}) do |f|
          f.use FaradayMiddleware::FollowRedirects, :limit => 3, :standards_compliant => true
          f.request(:url_encoded)
          f.adapter(Faraday.default_adapter)
          f.basic_auth(options[:username], options[:password])
        end
      end
    end

    def self.hosts
      Host
    end

    def self.job_templates
      JobTemplate
    end

    def self.ad_hoc_commands
      AdHocCommand
    end

    def self.method_missing(method_name, *args, &block)
      instance.respond_to?(method_name) ? instance.send(method_name, *args, &block) : super
    end

    def self.respond_to_missing?(method, _include_private = false)
      instance.respond_to?(method)
    end
  end
end
