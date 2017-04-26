module AnsibleTowerClient
  class MockApi
    module Config
      def self.response(version)
        {
          "eula"                => "text",
          "license_info"        => {
            "deployment_id"          => "123abc",
            "subscription_name"      => "Ansible Tower by Red Hat, Standard (10000 Managed Nodes)",
            "current_instances"      => 100,
            "features"               => {
              "surveys"                => true,
              "multiple_organizations" => true,
              "system_tracking"        => true,
              "enterprise_auth"        => true,
              "rebranding"             => true,
              "activity_streams"       => true,
              "ldap"                   => true,
              "ha"                     => true
            },
            "date_expired"           => false,
            "available_instances"    => 10000,
            "hostname"               => "123abc",
            "free_instances"         => 9900,
            "instance_count"         => 10000,
            "time_remaining"         => 26167901,
            "compliant"              => true,
            "grace_period_remaining" => 28759901,
            "contact_email"          => "someone@example.com",
            "company_name"           => "Your Company, Inc.",
            "date_warning"           => false,
            "license_type"           => "enterprise",
            "contact_name"           => "Someone",
            "license_date"           => 1518710102,
            "license_key"            => "123abc",
            "valid_key"              => true
          },
          "analytics_status"    => "detailed",
          "version"             => version || "3.0.1",
          "project_base_dir"    => "/var/lib/awx/projects",
          "time_zone"           => "America/New_York",
          "ansible_version"     => "2.1.0.0",
          "project_local_paths" => []
        }.to_json
      end
    end
  end
end
