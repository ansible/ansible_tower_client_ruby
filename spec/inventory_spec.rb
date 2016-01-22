require_relative 'spec_helper'

describe AnsibleTowerClient::Inventory do
  let(:inventories_body) do
    {:count => 2, :next => nil,
     :previous => nil,
     :results => [{:id => 1, :type => 'inventory',
                   :url => '/api/v1/inventories/1/', :name => 'test1'},
                  {:id => 2, :type => 'inventories',
                   :url => '/api/v1/inventories/2/', :name => 'test2'}]}.to_json
  end

  let(:one_result) do
    {:id => 1, :url => '/api/v1/inventories/1/', :name => 'test1'}.to_json
  end

  let(:api_connection) { instance_double("Faraday::Connection", :get => get) }

  describe '#Inventory.all' do
    let(:get) { instance_double("Faraday::Result", :body => inventories_body) }

    it "returns a list of inventory objects" do
      AnsibleTowerClient::Api.instance_variable_set(:@instance, api_connection)
      all_inventories = AnsibleTowerClient::Inventory.all
      expect(all_inventories).to        be_a Array
      expect(all_inventories.length).to eq(2)
      expect(all_inventories.first).to  be_a AnsibleTowerClient::Inventory
    end
  end

  describe '#initialize' do
    it "instantiates an AnsibleTowerClient::Inventory from a hash" do
      parsed = JSON.parse(inventories_body)['results'].first
      host = AnsibleTowerClient::Inventory.new(parsed)
      expect(host).to be_a AnsibleTowerClient::Inventory
      expect(host.id).to be_a Integer
      expect(host.name).to eq "test1"
    end
  end

  describe '#Inventory.find' do
    let(:get) { instance_double("Faraday::Result", :body => one_result) }

    it 'returns one record' do
      AnsibleTowerClient::Api.instance_variable_set(:@instance, api_connection)
      one_thing = AnsibleTowerClient::Inventory.find(1)
      expect(one_thing).to be_a AnsibleTowerClient::Inventory
    end
  end
end
