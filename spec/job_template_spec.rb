require 'faraday' # Only because we're doubling the connection

describe AnsibleTowerClient::JobTemplate do
  let(:url)                 { "example.com/api/v1/job_template_update/10" }
  let(:api)                 { AnsibleTowerClient::Api.new(connection).tap { |a| allow(a).to receive(:config).and_return(config) } }
  let(:collection)          { api.job_templates }
  let(:connection)          { instance_double("Faraday::Connection") }
  let(:config)              { {"version" => "1.1"} }
  let(:raw_collection)      { build(:response_collection, :klass => described_class) }
  let(:raw_url_collection)  { build(:response_url_collection, :klass => described_class, :url => url) }
  let(:raw_instance)        { build(:response_instance, :job_template, :klass => described_class) }
  let(:raw_instance_no_extra_vars) { build(:response_instance, :job_template, :klass => described_class, :extra_vars => '') }
  let(:raw_instance_no_survey)     { build(:response_instance, :job_template, :klass => described_class, :related => {}) }

  include_examples "Collection Methods"
  include_examples "Crud Methods"
  include_examples "JobTemplate#initialize"
  include_examples "JobTemplate#survey_spec"
  include_examples "JobTemplate#survey_spec_hash"
  include_examples "JobTemplate#extra_vars_hash"

  describe '#launch' do
    let(:json) { {'extra_vars' => "{\"instance_ids\":[\"i-999c\"],\"state\":\"absent\",\"subnet_id\":\"subnet-887\"}"} }
    let(:post_result_body) { {:job => 1} }
    let(:json_with_limit) { json.merge('limit' => 'machine_name') }

    it "runs an existing job template with a limit" do
      launch_url      = "#{raw_instance["url"]}launch/"
      response_double = instance_double("Faraday::Response", :body => post_result_body.to_json)
      expect_any_instance_of(AnsibleTowerClient::Collection).to receive(:find).with(post_result_body[:job])
      expect(api).to receive(:post).with(launch_url, json_with_limit).and_return(response_double)

      described_class.new(api, raw_instance).launch(json_with_limit)
    end
  end
end
