require_relative 'spec_helper'

describe AnsibleTowerClient::JobTemplate do
  let(:api)              { AnsibleTowerClient::Api.new(instance_double("Faraday::Connection")) }
  let(:collection)       { api.job_templates }
  let(:raw_collection)   { build(:response_collection, :klass => described_class) }
  let(:raw_instance)     { build(:response_instance, :job_template, :klass => described_class) }
  let(:raw_instance_no_extra_vars) { build(:response_instance, :job_template, :klass => described_class, :extra_vars => '') }
  let(:raw_instance_no_survey) { build(:response_instance, :job_template, :klass => described_class, :related => {}) }

  include_examples "Collection Methods"

  it "#initialize instantiates an #{described_class} from a hash" do
    obj = described_class.new(instance_double("AnsibleTowerClient::Api"), raw_instance)

    expect(obj).to             be_a described_class
    expect(obj.id).to          be_a Integer
    expect(obj.name).to        be_a String
    expect(obj.description).to be_a String
    expect(obj.related).to     be_a AnsibleTowerClient::JobTemplate::Related
    expect(obj.extra_vars).to  eq("{\"option\":\"lots of options\"}")
  end

  describe '#launch' do
    let(:json) { {'extra_vars' => "{\"instance_ids\":[\"i-999c\"],\"state\":\"absent\",\"subnet_id\":\"subnet-887\"}"} }
    let(:post_result_body) { {:job => 1} }

    it "runs an existing job template" do
      expect_any_instance_of(AnsibleTowerClient::Collection).to receive(:find).with(post_result_body[:job])
      expect(api).to receive(:post).and_return(instance_double("Faraday::Response", :body => post_result_body.to_json))
      expect(api).to receive(:patch).twice.and_return(instance_double("Faraday::Response", :body => post_result_body.to_json))

      described_class.new(api, raw_instance).launch(json)
    end

    it "handles limit when passed in" do
      expect_any_instance_of(AnsibleTowerClient::JobTemplate).to receive(:patch).twice
      described_class.new(api, raw_instance).send(:with_temporary_changes, 'test') { '' }
    end

    it "handles limit when passed in with a key as a symbol" do
      vars = {:extra_vars => {:blah => :nah}.to_json, :limit => 'test_string'}
      expect_job_template_responses
      described_class.new(api, raw_instance).launch(vars)
    end

    it "handles limit when passed in with a key as a string" do
      vars = {:extra_vars => {:blah => :nah}.to_json, 'limit' => 'test_string'}
      expect_job_template_responses
      described_class.new(api, raw_instance).launch(vars)
    end

    def expect_job_template_responses
      expect_any_instance_of(AnsibleTowerClient::Collection).to receive(:find).with(post_result_body[:job])
      expect(api).to receive(:post).and_return(instance_double("Faraday::Response", :body => post_result_body.to_json))
      expect_any_instance_of(AnsibleTowerClient::JobTemplate).to receive(:patch).once.with("{ \"limit\": \"test_string\" }")
      expect_any_instance_of(AnsibleTowerClient::JobTemplate).to receive(:patch).once.with("{ \"limit\": \"\" }")
    end
  end

  context '#survey_spec' do
    describe "exists" do
      let(:survey_spec) { "{\"description\":\"blah\"}" }
      it "returns a survey spec" do
        expect(api).to receive(:get).and_return(instance_double("Faraday::Result", :body => survey_spec))
        expect(described_class.new(api, raw_instance).survey_spec).to eq(survey_spec)
      end
    end

    describe "does not exist" do
      it "returns nil" do
        expect(described_class.new(api, raw_instance_no_survey).survey_spec).to be_nil
      end
    end
  end

  context '#survey_spec_hash' do
    describe "exists" do
      let(:survey_spec) { "{\"description\":\"blah\"}" }
      it "returns a hashed value" do
        expect(api).to receive(:get).twice.and_return(instance_double("Faraday::Result", :body => survey_spec))
        expect(described_class.new(api, raw_instance).survey_spec_hash).to eq("description" => "blah")
      end
    end

    describe "does not exist" do
      it "returns an empty hash" do
        expect(described_class.new(api, raw_instance_no_survey).survey_spec_hash).to be_empty
        expect(described_class.new(api, raw_instance_no_survey).survey_spec_hash).to be_a_kind_of(Hash)
      end
    end
  end

  describe "#extra_vars_hash" do
    describe "#extra_vars exists" do
      it "returns a hashed value" do
        obj = described_class.new(instance_double("AnsibleTowerClient::Api"), raw_instance)
        expect(obj.extra_vars_hash).to eq('option' => 'lots of options')
      end
    end

    describe "#extra_vars does not exist" do
      it "returns an empty hash" do
        obj = described_class.new(instance_double("AnsibleTowerClient::Api"), raw_instance_no_extra_vars)
        expect(obj.extra_vars_hash).to be_a_kind_of(Hash)
        expect(obj.extra_vars_hash).to be_empty
      end
    end
  end
end
