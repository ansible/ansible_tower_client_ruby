require 'spec_helper'

describe AnsibleTowerClient::CollectionMethods do
  let(:things_body) do
    {:count => 2, :next => nil,
     :previous => nil,
     :results => [{:id => 1,
                   :url => '/api/v1/things/1', :name => 'test1'},
                  {:id => 2,
                   :url => '/api/v1/things/2', :name => 'test2'}]}.to_json
  end

  let(:one_result) do
    {:id => 1, :url => '/api/v1/things/1', :name => 'test1'}.to_json
  end
  let(:api_connection) { instance_double("Faraday::Connection", :get => get) }
  let(:get) { instance_double("Faraday::Result", :body => things_body) }

  it "#all returns an array of the caller objects" do
    AnsibleTowerClient::Api.instance_variable_set(:@instance, api_connection)
    all_things = AnsibleTowerClient::JobTemplate.all
    all_more_things = AnsibleTowerClient::Host.all
    expect(all_things).to             be_a Array
    expect(all_things.length).to      eq(2)
    expect(all_things.first).to       be_a AnsibleTowerClient::JobTemplate
    expect(all_more_things).to        be_a Array
    expect(all_more_things.length).to eq(2)
    expect(all_more_things.first).to  be_a AnsibleTowerClient::Host
  end

  context "#find" do
    let(:get) { instance_double("Faraday::Result", :body => one_result) }
    it "returns a record when the id exists" do
      AnsibleTowerClient::Api.instance_variable_set(:@instance, api_connection)
      one_thing = AnsibleTowerClient::JobTemplate.find(1)
      expect(one_thing).to be_a AnsibleTowerClient::JobTemplate
    end
  end

  context "#find" do
    let(:get) { instance_double("Faraday::Result", :body => {}.to_json) }
    it "raises an error when the id does not exist" do
      AnsibleTowerClient::Api.instance_variable_set(:@instance, api_connection)
      expect { AnsibleTowerClient::JobTemplate.find(10) }.to raise_exception
    end
  end
end

