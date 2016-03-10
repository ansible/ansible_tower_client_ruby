require_relative 'spec_helper'
require 'json'

describe AnsibleTowerClient::Connection do
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

  it "#initialize returns a connection instance" do
    expect(connection).to be_a AnsibleTowerClient::Connection
  end

  context "requiring a connection" do
    before { allow(Faraday).to receive(:new).and_return(faraday_connection) }

    describe "config" do
      let(:get) { instance_double("Faraday::Result", :body => config_body) }

      it "#config returns the server config" do
        json = connection.config
        expect(json['eula']).to eq "text"
        expect(json['license_info']).to be_a Hash
      end

      it "#version returns the ansible tower version" do
        expect(connection.version).to eq "2.4.2"
      end
    end

    describe "#verify_credentials" do
      let(:get) { instance_double("Faraday::Result", :body => credentials_body) }

      it "returns the username" do
        expect(connection.verify_credentials).to eq "admin"
      end
    end
  end

  it ".new doesn't cache credentials across all instances" do
    conn_1 = described_class.new(:base_url => "example1.com", :username => "admin", :password => "smartvm", :verify_ssl => OpenSSL::SSL::VERIFY_NONE)
    conn_2 = described_class.new(:base_url => "example2.com", :username => "user", :password => "password", :verify_ssl => OpenSSL::SSL::VERIFY_NONE)

    expect(conn_1.api.instance).not_to eq(conn_2.api.instance)
  end
end
