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

    it "raises an error with invalid JSON" do
      vars_invalid = AnsibleTowerClient::JSONValues.new(invalid_json)
      expect { vars_invalid.extra_vars }.to raise_error AnsibleTowerClient::InvalidJson
    end
  end
end
