require_relative 'spec_helper'
require 'json'

describe AnsibleTowerClient::Host do
  let(:config_body) do
    {:count => 2, :next => nil,
     :previous => nil,
     :results => [{:id => 1, :type => 'host',
                   :url => '/api/v1/hosts/1', :name => 'test1'},
                  {:id => 2, :type => 'host',
                   :url => '/api/v1/hosts/2', :name => 'test2'}]}.to_json
  end

  let(:faraday_connection) { instance_double("Faraday::Connection", :get => get) }

  describe '#Host.all' do
    let(:get) { instance_double("Faraday::Result", :body => config_body) }

    it "returns a list of host objects" do
      all_hosts = AnsibleTowerClient::Host.all(faraday_connection)
      expect(all_hosts.first).to be_a AnsibleTowerClient::Host
      expect(all_hosts).to be_a Array
    end
  end

  describe '#initialize' do
    it "instantiates an AnsibleTowerClient::Host from a hash" do
      parsed = JSON.parse(config_body)['results'].first
      host = AnsibleTowerClient::Host.new(parsed)
      expect(host).to be_a AnsibleTowerClient::Host
      expect(host.id).to be_a Integer
      expect(host.url).to be_a String
      expect(host.name).to eq "test1"
    end
  end
end
