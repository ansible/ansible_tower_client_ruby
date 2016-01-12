require 'spec_helper'

describe 'AnsibleTowerClient::NullLogger' do
  it "returns a null logger" do
    expect(AnsibleTowerClient.logger).to be_a AnsibleTowerClient::NullLogger
  end
end
