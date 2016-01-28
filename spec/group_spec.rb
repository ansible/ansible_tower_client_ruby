require_relative 'spec_helper'

describe AnsibleTowerClient::Group do
  let(:groups_body) do
    {:count => 2, :next => nil,
     :previous => nil,
     :results => [{:id => 1, :type => 'group',
                   :url => '/api/v1/groups/1/', :name => 'test1'},
                  {:id => 2, :type => 'groups',
                   :url => '/api/v1/groups/2/', :name => 'test2'}]}.to_json
  end

  let(:one_result) do
    {:id => 1, :url => '/api/v1/groups/1/', :name => 'test1'}.to_json
  end

  let(:api_connection) { instance_double("Faraday::Connection", :get => get) }

  describe '#Group.all' do
    let(:get) { instance_double("Faraday::Result", :body => groups_body) }

    it "returns a list of group objects" do
      AnsibleTowerClient::Api.instance_variable_set(:@instance, api_connection)
      all_groups = AnsibleTowerClient::Group.all
      expect(all_groups).to        be_a Array
      expect(all_groups.length).to eq(2)
      expect(all_groups.first).to  be_a AnsibleTowerClient::Group
    end
  end

  describe '#initialize' do
    it "instantiates an AnsibleTowerClient::Group from a hash" do
      parsed = JSON.parse(groups_body)['results'].first
      host = AnsibleTowerClient::Group.new(parsed)
      expect(host).to be_a AnsibleTowerClient::Group
      expect(host.id).to be_a Integer
      expect(host.name).to eq "test1"
    end
  end

  describe '#Group.find' do
    let(:get) { instance_double("Faraday::Result", :body => one_result) }

    it 'returns one record' do
      AnsibleTowerClient::Api.instance_variable_set(:@instance, api_connection)
      one_thing = AnsibleTowerClient::Group.find(1)
      expect(one_thing).to be_a AnsibleTowerClient::Group
    end
  end
end
