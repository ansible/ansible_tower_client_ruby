require_relative 'spec_helper'

describe AnsibleTowerClient::AdHocCommand do
  let(:ad_hoc_commands_body) do
    {:count => 2, :next => nil,
     :previous => nil,
     :results => [{:id => 1, :type => 'ad_hoc_command',
                   :url => '/api/v1/ad_hoc_commands/1/', :name => 'test1'},
                  {:id => 2, :type => 'ad_hoc_commands',
                   :url => '/api/v1/ad_hoc_commands/2/', :name => 'test2'}]}.to_json
  end

  let(:one_result) do
    {:id => 1, :url => '/api/v1/ad_hoc_commands/1/', :name => 'test1'}.to_json
  end

  let(:api_connection) { instance_double("Faraday::Connection", :get => get) }

  describe '#AdHocCommand.all' do
    let(:get) { instance_double("Faraday::Result", :body => ad_hoc_commands_body) }

    it "returns a list of ad_hoc_command objects" do
      AnsibleTowerClient::Api.instance_variable_set(:@instance, api_connection)
      all_ad_hoc_commands = AnsibleTowerClient::AdHocCommand.all
      expect(all_ad_hoc_commands).to        be_a Array
      expect(all_ad_hoc_commands.length).to eq(2)
      expect(all_ad_hoc_commands.first).to  be_a AnsibleTowerClient::AdHocCommand
    end
  end

  describe '#initialize' do
    it "instantiates an AnsibleTowerClient::AdHocCommand from a hash" do
      parsed = JSON.parse(ad_hoc_commands_body)['results'].first
      host = AnsibleTowerClient::AdHocCommand.new(parsed)
      expect(host).to be_a AnsibleTowerClient::AdHocCommand
      expect(host.id).to be_a Integer
      expect(host.name).to eq "test1"
    end
  end

  describe '#AdHocCommand.find' do
    let(:get) { instance_double("Faraday::Result", :body => one_result) }

    it 'returns one record' do
      AnsibleTowerClient::Api.instance_variable_set(:@instance, api_connection)
      one_thing = AnsibleTowerClient::AdHocCommand.find(1)
      expect(one_thing).to be_a AnsibleTowerClient::AdHocCommand
    end
  end
end

