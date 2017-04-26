describe AnsibleTowerClient::AdHocCommand do
  let(:api)          { AnsibleTowerClient::Api.new(AnsibleTowerClient::MockApi.new) }
  let(:raw_instance) { build(:response_instance, :klass => described_class) }

  include_examples "Crud Methods"

  it "#initialize instantiates an #{described_class} from a hash" do
    obj = api.ad_hoc_commands.all.first

    expect(obj).to      be_a described_class
    expect(obj.id).to   be_a Integer
    expect(obj.name).to be_a String
  end
end
