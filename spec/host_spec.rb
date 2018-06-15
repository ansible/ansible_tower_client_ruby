describe AnsibleTowerClient::Host do
  let(:url)          { "example.com/api/v1/hosts" }
  let(:api)          { AnsibleTowerClient::Api.new(AnsibleTowerClient::MockApi.new, 1) }
  let(:raw_instance) { build(:response_instance, :host, :klass => described_class) }

  include_examples "Api Methods"
  include_examples "Crud Methods"

  it "#initialize instantiates an #{described_class} from a hash" do
    obj = api.hosts.all.first

    expect(obj).to              be_a described_class
    expect(obj.id).to           be_a Integer
    expect(obj.url).to          be_a String
    expect(obj.instance_id).to  be_a String
    expect(obj.inventory_id).to be_a Integer
    expect(obj.name).to         be_a String
  end
end
