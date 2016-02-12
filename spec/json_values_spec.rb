require 'spec_helper'

describe AnsibleTowerClient::JSONValues do
  describe '#initialize' do
    let(:valid_json) do
      {'extra_vars' => "{\"instance_ids\":[\"i-999c\"],\"state\":\"absent\",\"subnet_id\":\"subnet-887\"}"}
    end

    let(:invalid_json) do
      {'extra_vars' => 'abcdefg'}
    end

    it "requires a hash as an argument" do
      expect { AnsibleTowerClient::JSONValues.new("") }.to raise_error AnsibleTowerClient::InvalidHash
    end

    it "returns a hash with valid JSON" do
      vars = AnsibleTowerClient::JSONValues.new(valid_json)
      expect(vars.extra_vars).to be_a Hash
    end

    it "raises an error with any invalid JSON" do
      expect { AnsibleTowerClient::JSONValues.new(invalid_json) }.to raise_error AnsibleTowerClient::InvalidJSON
    end

    it "creates an attr_reader for each valid json key" do
      vars = AnsibleTowerClient::JSONValues.new(valid_json)
      expect(vars.extra_vars).to eq JSON.parse(valid_json['extra_vars'])
      expect { vars.blah_method }.to raise_error NoMethodError
    end
  end
end
