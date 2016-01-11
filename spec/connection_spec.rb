require_relative 'spec_helper'
require 'json'

describe AnsibleTowerClient::Connection do
  let(:hosts_body) do
    {:count => 2, :next => nil,
     :previous => nil,
     :results => [{:id => 1, :type => 'host',
                   :url => '/api/v1/hosts/1'},
                  {:id => 2, :type => 'host',
                   :url => '/api/v1/hosts/2'}]}.to_json
  end

  let(:config_body) do
    {:eula => 'text',
     :license_info => {:deployment_id => 'werwer', :contact_name => 'Fred Tester'},
     :version => '2.4.2', :ansible_version => '1.9.4',
     :project_local_paths => []}.to_json
  end

  let(:credentials_body) do
    {:count => 1, :next => nil, :previous => nil,
     :results => [{:id => 1, :type => 'user',
                   :url => '/api/v1/users/1',
                   :username => 'admin'}]}.to_json
  end

  let(:faraday_connection) { instance_double("Faraday::Connection", :get => get) }

  let(:connection) do
    described_class.new(:base_url   => "example.com",
                        :username   => "admin",
                        :password   => "smartvm",
                        :verify_ssl => OpenSSL::SSL::VERIFY_NONE)
  end

  describe "#config" do
    let(:get) { instance_double("Faraday::Result", :body => config_body) }

    before do
      connection.instance_variable_set("@connection", faraday_connection)
    end

    it "returns the server config" do
      json = connection.config
      expect(json['eula']).to eq "text"
      expect(json['license_info']).to be_a Hash
    end
  end

  describe "#initialize" do
    it "returns a connection" do
      expect(connection).to be_a AnsibleTowerClient::Connection
    end
  end

  describe "#hosts" do
    let(:get) { instance_double("Faraday::Result", :body => hosts_body) }
    before do
      connection.instance_variable_set("@connection", faraday_connection)
    end

    context "with 2 hosts" do
      it "returns a list of hosts" do
        expect(connection.hosts.size).to eq 2
        expect(connection.hosts.first).to be_a AnsibleTowerClient::Host
      end
    end
  end

  describe "#version" do
    let(:get) { instance_double("Faraday::Result", :body => config_body) }

    before do
      connection.instance_variable_set("@connection", faraday_connection)
    end

    it "returns the version" do
      expect(connection.version).to eq "2.4.2"
    end
  end

  describe "#verify_credentials" do
    let(:get) { instance_double("Faraday::Result", :body => credentials_body) }

    before do
      connection.instance_variable_set("@connection", faraday_connection)
    end

    it "returns the username" do
      expect(connection.verify_credentials).to eq "admin"
    end
  end
end
