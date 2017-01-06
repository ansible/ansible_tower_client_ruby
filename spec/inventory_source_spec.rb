describe AnsibleTowerClient::InventorySource do
  let(:url)                 { "example.com/api/v1/inventory_source/10" }
  let(:api)                 { AnsibleTowerClient::Api.new(instance_double("Faraday::Connection")) }
  let(:collection)          { api.inventory_sources }
  let(:raw_collection)      { build(:response_collection, :klass => described_class) }
  let(:raw_url_collection)  { build(:response_url_collection, :klass => described_class, :url => url) }
  let(:raw_instance)        { build(:response_instance, :klass => described_class) }

  include_examples "Collection Methods"
  include_examples "Crud Methods"

  it "#initialize instantiates an #{described_class} from a hash" do
    obj = described_class.new(instance_double("AnsibleTowerClient::Api"), raw_instance)

    expect(obj).to      be_a described_class
    expect(obj.id).to   be_a Integer
    expect(obj.name).to be_a String
  end

  describe '#can_update?' do
    let(:can_update_true)   { {'can_update' => true}  }
    let(:can_update_false)  { {'can_update' => false} }

    it 'returns true' do
      expect(api).to receive(:get).and_return(instance_double("Faraday::Response", :body => can_update_true.to_json))
      expect(described_class.new(api, raw_instance).can_update?).to be_truthy
    end

    it 'returns false' do
      expect(api).to receive(:get).and_return(instance_double("Faraday::Response", :body => can_update_false.to_json))
      expect(described_class.new(api, raw_instance).can_update?).to be_falsey
    end
  end

  describe '#update' do
    let(:post_result_body) { {:inventory_update => 1} }

    it "updates an inventory_source" do
      expect_any_instance_of(AnsibleTowerClient::Collection).to receive(:find).with(post_result_body[:inventory_update])
      expect(api).to receive(:post).and_return(instance_double("Faraday::Response", :body => post_result_body.to_json))

      described_class.new(api, raw_instance).update
    end
  end
end
