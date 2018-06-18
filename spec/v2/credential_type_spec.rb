describe AnsibleTowerClient::CredentialTypeV2 do
  let(:api)                        { AnsibleTowerClient::Api.new(connection, 2) }
  let(:connection)                 { AnsibleTowerClient::MockApi.new }
  let(:raw_instance)               { build(:response_instance, :credential_type, :klass => described_class) }

  include_examples "Crud Methods"

  it "#initialize instantiates an #{described_class} from a hash" do
    obj = api.credential_types.all.detect { |cred| cred.name == 'Nuage' }

    expect(obj).to                    be_a described_class
    expect(obj.id).to                 be_a Integer
    expect(obj.url).to                be_a String
    expect(obj.name).to               be_a String
    expect(obj.kind).to               be_a String
    expect(obj.managed_by_tower).to   eq false
    expect(obj.inputs).to             be_a AnsibleTowerClient::CredentialTypeV2::Inputs
    expect(obj.inputs.fields).to      be_a Array
    expect(obj.inputs.required).to    be_a Array
    expect(obj.injectors).to          be_a AnsibleTowerClient::CredentialTypeV2::Injectors
  end

  context 'override_raw_attributes' do
    let(:obj) { described_class.new(instance_double("Faraday::Connection"), raw_instance) }
    let(:instance_api) { obj.instance_variable_get(:@api) }
  end
end
