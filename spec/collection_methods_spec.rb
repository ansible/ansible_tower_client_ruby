require 'spec_helper'

describe AnsibleTowerClient::CollectionMethods do
  context "#find" do
    let(:api_connection) { instance_double("Faraday::Connection", :get => get) }
    let(:get) { instance_double("Faraday::Result", :body => {}.to_json) }

    it "raises an error when the id does not exist" do
      AnsibleTowerClient::Api.instance_variable_set(:@instance, api_connection)
      expect { AnsibleTowerClient::JobTemplate.find(10) }.to raise_error(AnsibleTowerClient::ResourceNotFound)
    end
  end
end
