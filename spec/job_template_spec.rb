require_relative 'spec_helper'

describe AnsibleTowerClient::JobTemplate do
  let(:api_connection)   { instance_double("Faraday::Connection", :get => get, :post => post) }
  let(:collection)       { build(:response_collection, :klass => described_class) }
  let(:instance)         { build(:response_instance, :description, :extra_vars, :klass => described_class) }
  let(:post)             { instance_double("Faraday::Response", :body => post_result_body.to_json) }
  let(:post_result_body) { {:job => 1} }

  include_examples "Collection Methods"

  it "#initialize instantiates an #{described_class} from a hash" do
    obj = described_class.new(instance)

    expect(obj).to             be_a described_class
    expect(obj.id).to          be_a Integer
    expect(obj.name).to        be_a String
    expect(obj.description).to be_a String
    expect(obj.extra_vars).to  eq("lots of options")
  end

  describe '#launch' do
    let(:get)  { instance_double("Faraday::Result", :body => instance.to_json) }
    let(:json) { {'extra_vars' => "{\"instance_ids\":[\"i-999c\"],\"state\":\"absent\",\"subnet_id\":\"subnet-887\"}"} }

    it "runs an existing job template" do
      AnsibleTowerClient::Api.instance_variable_set(:@instance, api_connection)

      expect(AnsibleTowerClient::Job).to receive(:find).with(post_result_body[:job])

      described_class.new(instance).launch(json)
    end
  end
end
