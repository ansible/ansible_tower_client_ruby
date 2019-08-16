module AnsibleTowerClient
  class Credential < BaseModel
    def override_raw_attributes
      {
        :organization    => :organization_id,
        :credential_type => :credential_type_id,
      }
    end

    # https://github.com/ansible/awx/blob/1328fb80a02ef4e37bc021eb07d4be041a41f937/awx/main/models/credential/__init__.py#L76-L90
    KIND_CHOICES = {
      'ssh'        => 'Machine',
      'net'        => 'Network',
      'scm'        => 'Source Control',
      'aws'        => 'Amazon Web Services',
      'vmware'     => 'VMware vCenter',
      'satellite6' => 'Red Hat Satellite 6',
      'cloudforms' => 'Red Hat CloudForms',
      'gce'        => 'Google Compute Engine',
      'azure_rm'   => 'Microsoft Azure Resource Manager',
      'openstack'  => 'OpenStack',
      'rhv'        => 'Red Hat Virtualization',
      'insights'   => 'Insights',
      'tower'      => 'Ansible Tower',
    }.invert
    KIND_CHOICES.default = 'cloud'
    KIND_CHOICES.freeze

    # https://github.com/ansible/awx/blob/1328fb80a02ef4e37bc021eb07d4be041a41f937/awx/main/models/credential/__init__.py#L301
    def kind
      @data['kind'] ||= begin
        kind = credential_type.kind
        kind == 'cloud' ? KIND_CHOICES[credential_type.name] : kind
      end.to_s
    end

    def credential_type
      @credential_type ||= api.credential_types.find(credential_type_id)
    end

    def vault_password
      @data['vault_password'] ||= begin
        has_vault_password = respond_to?(:inputs) && inputs.respond_to?(:vault_password)
        (inputs.vault_password if has_vault_password).to_s
      end
    end
  end
end
