require 'spec_helper'

describe AnsibleTowerClient::Data do
  describe '#initialize' do
    let(:valid_json) do
      {'extra_vars' => "{\"instance_ids\":[\"i-999c\"],\"state\":\"absent\",\"subnet_id\":\"subnet-887\"}"}
    end

    let(:valid_multiple) do
      {'extra_vars' => "{\"instance_ids\":[\"i-999c\"],\"state\":\"absent\",\"subnet_id\":\"subnet-887\"}",
       :survey_spec => {:blah => :nah}.to_json}
    end

    let(:invalid_yaml) do
      {'extra_vars' => :abcdefg}
    end

    it "requires a hash as an argument" do
      expect { AnsibleTowerClient::Data.validate!("") }.to raise_error AnsibleTowerClient::InvalidHash
    end

    it "returns a hash with valid JSON" do
      vars = AnsibleTowerClient::Data.validate!(valid_json)
      expect(vars).to be_a Hash
      expect(vars.keys.first).to eq 'extra_vars'
    end

    it "returns all passed in keys as a valid tower hash" do
      vars = AnsibleTowerClient::Data.validate!(valid_multiple)
      expect(vars).to be_a Hash
      expect(vars.keys.first).to eq 'extra_vars'
      expect(vars.keys.last).to eq 'survey_spec'
    end

    it "raises an error with invalid YAML" do
      expect { AnsibleTowerClient::Data.validate!(invalid_yaml) }.to raise_error AnsibleTowerClient::InvalidYaml
    end
  end
end
