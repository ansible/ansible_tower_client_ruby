require_relative 'spec_helper'

describe AnsibleTowerClient::Inventory do
  let(:url)                 { "example.com/api/v1/inventory_sources" }
  let(:api)                 { AnsibleTowerClient::Api.new(instance_double("Faraday::Connection")) }
  let(:collection)          { api.inventories }
  let(:raw_collection)      { build(:response_collection, :klass => described_class) }
  let(:raw_url_collection)  { build(:response_url_collection, :klass => described_class, :url => url) }
  let(:inventory_source)    { build(:response_url_collection, :klass => AnsibleTowerClient::InventorySource) }
  let(:raw_instance)        { build(:response_instance, :klass => described_class) }

  include_examples "Collection Methods"

  it "#initialize instantiates an #{described_class} from a hash" do
    obj = described_class.new(instance_double("AnsibleTowerClient::Api"), raw_instance)

    expect(obj).to      be_a described_class
    expect(obj.id).to   be_a Integer
    expect(obj.name).to be_a String
  end

  describe "#inventory_sources" do
    it "#inventory_sources returns a list of inventory_sources" do
      expect(api).to receive(:get).and_return(instance_double("Faraday::Result", :body => inventory_source.to_json))
      inventory_sources = described_class.new(api, raw_instance).inventory_sources
      expect(inventory_sources).to be_a Array
      expect(inventory_sources.count).to eq 1
    end
  end

  describe "#update_all_inventory_sources" do
    let(:can_update_true)   { {'can_update' => true}  }
    let(:can_update_false)  { {'can_update' => false} }
    let(:post_result_body) { {:inventory_update => 1} }
    let(:inventory_sources) do
      [described_class.new(instance_double("AnsibleTowerClient::Api"), inventory_source)]
    end
    let(:obj) { described_class.new(instance_double("AnsibleTowerClient::Api"), raw_instance) }

    before do
      expect(obj).to receive(:inventory_sources).and_return(inventory_sources)
    end

    it "updates an inventory_source if #can_update? is true" do
      expect(inventory_sources.first).to receive(:can_update?).and_return(can_update_true['can_update'])
      expect(inventory_sources.first).to receive(:update).once.and_return(post_result_body)

      obj.update_all_inventory_sources
    end

    it "does not update an inventory_source if #can_update? is true" do
      expect(inventory_sources.first).to receive(:can_update?).and_return(can_update_false['can_update'])

      obj.update_all_inventory_sources
    end
  end
end
