require_relative 'spec_helper'

describe AnsibleTowerClient::Group do
  let(:api_connection) { instance_double("Faraday::Connection", :get => get) }
  let(:collection)     { build(:response_collection, :klass => described_class) }
  let(:instance)       { build(:response_instance,   :klass => described_class) }

  context "Collection Methods" do
    describe '.all' do
      let(:get) { instance_double("Faraday::Result", :body => collection.to_json) }

      it "returns a collection of objects" do
        AnsibleTowerClient::Api.instance_variable_set(:@instance, api_connection)
        obj_collection = described_class.all
        expect(obj_collection).to        be_a Array
        expect(obj_collection.length).to eq(2)
        expect(obj_collection.first).to  be_a described_class
      end
    end

    describe '.find' do
      let(:get) { instance_double("Faraday::Result", :body => instance.to_json) }

      it 'returns an instance' do
        AnsibleTowerClient::Api.instance_variable_set(:@instance, api_connection)
        expect(described_class.find(1)).to be_a described_class
      end
    end
  end

  it "#initialize instantiates an #{described_class} from a hash" do
    obj = described_class.new(instance)

    expect(obj).to      be_a described_class
    expect(obj.id).to   be_a Integer
    expect(obj.name).to be_a String
  end
end
