require 'spec_helper'

describe AnsibleTowerClient::InstanceMethods do
  let(:one_result) do
    {'id' => 1, 'url' => '/api/v1/things/1/',
     'name' => 'test1',
     'related' => {'blah' => 'blah'},
     'summary_fields' => {'nah' => 'nah'}
    }
  end
  let(:new_object) { AnsibleTowerClient::Host.new(one_result) }


  it "#initialize" do
    expect(new_object).to be_a(AnsibleTowerClient::Host)
  end

  it "#related" do
    expect(new_object.related.values).to eq ['blah']
  end

  it "#summary_fields" do
    expect(new_object.summary_fields.values).to eq ['nah']
  end
end
