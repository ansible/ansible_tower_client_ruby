require 'spec_helper'

describe AnsibleTowerClient::Collection do
  context "#find" do
    let(:api) { AnsibleTowerClient::Api.new(instance_double("Faraday::Connection")) }

    it "raises an error when the id does not exist" do
      expect(api).to receive(:get).and_return(instance_double("Faraday::Result", :body => {}.to_json))

      expect { api.job_templates.find(10) }.to raise_error(AnsibleTowerClient::ResourceNotFound)
    end
  end
end
