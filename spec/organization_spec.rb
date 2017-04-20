describe AnsibleTowerClient::Organization do
  let(:url)                 { "example.com/api/v1/organizations/13" }
  let(:api)                 { AnsibleTowerClient::Api.new(instance_double("Faraday::Connection")) }
  let(:collection)          { api.organizations }
  let(:raw_collection)      { build(:response_collection, :klass => described_class) }
  let(:raw_url_collection)  { build(:response_url_collection, :klass => described_class, :url => url) }
  let(:raw_instance)        { build(:response_instance, :organization, :klass => described_class, :description => "The Organization", :name => "MyOrg") }

  include_examples "Crud Methods"

  it "#initialize instantiates an #{described_class} from a hash" do
    obj = described_class.new(instance_double("AnsibleTowerClient::Api"), raw_instance)

    expect(obj).to              be_a described_class
    expect(obj.id).to           be_a Integer
    expect(obj.url).to          be_a String
    expect(obj.description).to  eq "The Organization"
    expect(obj.name).to         be_a String
  end
end
