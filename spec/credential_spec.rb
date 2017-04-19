describe AnsibleTowerClient::Credential do
  let(:api)          { AnsibleTowerClient::Api.new(AnsibleTowerClient::MockApi.new) }
  let(:raw_instance) { build(:response_instance, :credential, :klass => described_class) }

  include_examples "Crud Methods"

  it "#initialize instantiates an #{described_class} from a hash" do
    obj = api.credentials.all.first

    expect(obj).to              be_a described_class
    expect(obj.id).to           be_a Integer
    expect(obj.url).to          be_a String
    expect(obj.kind).to         eq "aws"
    expect(obj.username).to     be_a String
    expect(obj.name).to         be_a String
  end
end
