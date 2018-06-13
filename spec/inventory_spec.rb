describe AnsibleTowerClient::Inventory do
  let(:url)              { "example.com/api/v1/inventories" }
  let(:api)              { AnsibleTowerClient::Api.new(AnsibleTowerClient::MockApi.new, 1) }
  let(:inventory_source) { build(:response_url_collection, :klass => AnsibleTowerClient::InventorySource) }
  let(:raw_instance)     { build(:response_instance, :klass => described_class) }
  let(:instance)         { api.inventories.all.first }

  include_examples "Api Methods"
  include_examples "Crud Methods"

  it "#initialize instantiates an #{described_class} from a hash" do
    expect(instance).to      be_a described_class
    expect(instance.id).to   be_a Integer
    expect(instance.name).to be_a String
  end

  describe "#inventory_sources" do
    it "#inventory_sources returns a list of inventory_sources" do
      expect_any_instance_of(described_class).to receive(:related).and_return("inventory_sources" => "abc")
      expect(api).to receive(:get).and_return(instance_double("Faraday::Result", :body => inventory_source.to_json))
      inventory_sources = described_class.new(api, raw_instance).inventory_sources.to_a
      expect(inventory_sources.to_a.count).to eq 1
    end
  end

  describe "#update_all_inventory_sources" do
    let(:can_update_true)   { {'can_update' => true}  }
    let(:can_update_false)  { {'can_update' => false} }
    let(:post_result_body)  { {:inventory_update => 1} }
    let(:inventory_sources) do
      [described_class.new(instance_double("AnsibleTowerClient::Api"), inventory_source)]
    end

    before do
      expect(instance).to receive(:inventory_sources).and_return(inventory_sources)
    end

    it "updates an inventory_source if #can_update? is true" do
      expect(inventory_sources.first).to receive(:can_update?).and_return(can_update_true['can_update'])
      expect(inventory_sources.first).to receive(:update).once.and_return(post_result_body)

      instance.update_all_inventory_sources
    end

    it "does not update an inventory_source if #can_update? is false" do
      expect(inventory_sources.first).to receive(:can_update?).and_return(can_update_false['can_update'])

      instance.update_all_inventory_sources
    end
  end
end
