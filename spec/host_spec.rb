require_relative 'spec_helper'
require 'json'

describe AnsibleTowerClient::Host do
  let(:api_connection) { instance_double("Faraday::Connection", :get => get) }
  let(:collection)     { build(:response_collection, :klass => described_class) }
  let(:instance)       { build(:response_instance, :host, :klass => described_class) }

  include_examples "Collection Methods"

  it "#initialize instantiates an #{described_class} from a hash" do
    obj = described_class.new(instance)

    expect(obj).to              be_a described_class
    expect(obj.id).to           be_a Integer
    expect(obj.url).to          be_a String
    expect(obj.instance_id).to  be_a String
    expect(obj.inventory_id).to be_a Integer
    expect(obj.name).to         be_a String
  end
end
