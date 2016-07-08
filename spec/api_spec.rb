require 'json'

describe AnsibleTowerClient::Api do
  let(:faraday_connection) { instance_double("Faraday::Connection") }

  subject { described_class.new(faraday_connection) }

  it "#instance returns an existing instance" do
    expect(subject.instance).to be(faraday_connection)
  end

  it "#hosts returns a collection" do
    expect(subject.hosts).to be_kind_of(AnsibleTowerClient::Collection)
  end
end

