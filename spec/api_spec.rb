require_relative 'spec_helper'
require 'json'

describe AnsibleTowerClient::Api do
  let(:faraday_connection) { instance_double("Faraday::Connection") }

  let(:connection) do
    described_class.new(:base_url   => "example.com",
                        :username   => "admin",
                        :password   => "smartvm",
                        :verify_ssl => OpenSSL::SSL::VERIFY_NONE)
  end

  it "#instance returns an existing instance" do
    described_class.instance_variable_set(:@instance, faraday_connection)
    expect(described_class.instance).to be(faraday_connection)
  end

  it "#hosts returns the Host class" do
    expect(described_class.hosts).to eq(AnsibleTowerClient::Host)
  end
end

