describe AnsibleTowerClient::Organization do
  let(:api)          { AnsibleTowerClient::Api.new(AnsibleTowerClient::MockApi.new, 1) }
  let(:raw_instance) { build(:response_instance, :organization, :klass => described_class, :description => "The Organization", :name => "MyOrg") }

  include_examples "Crud Methods"

  it "#initialize instantiates an #{described_class} from a hash" do
    obj = api.organizations.all.first

    expect(obj).to             be_a described_class
    expect(obj.id).to          be_a Integer
    expect(obj.url).to         be_a String
    expect(obj.description).to eq "The Organization"
    expect(obj.name).to        be_a String
  end
end
