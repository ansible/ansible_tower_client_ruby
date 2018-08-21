describe AnsibleTowerClient::JobTemplate do
  let(:url)                        { "example.com/api/v1/job_templates" }
  let(:api)                        { AnsibleTowerClient::Api.new(AnsibleTowerClient::MockApi.new("1.1")) }
  let(:raw_instance)               { build(:response_instance, :job_template, :klass => described_class) }
  let(:raw_instance_no_extra_vars) { build(:response_instance, :job_template, :klass => described_class, :extra_vars => '') }
  let(:raw_instance_no_survey)     { build(:response_instance, :job_template, :klass => described_class, :related => {}) }

  include_examples "Api Methods"
  include_examples "Crud Methods"
  include_examples "JobTemplate#extra_vars_hash"
  include_examples "JobTemplate#initialize"
  include_examples "JobTemplate#survey_spec"
  include_examples "JobTemplate#survey_spec_hash"

  describe '#launch' do
    let(:json) { {'extra_vars' => "{\"instance_ids\":[\"i-999c\"],\"state\":\"absent\",\"subnet_id\":\"subnet-887\"}"} }
    let(:post_result_body) { {:job => 1} }
    let(:json_with_limit) { json.merge('limit' => 'machine_name') }
    let(:response_double) { instance_double("Faraday::Response", :body => post_result_body.to_json) }

    it "runs an existing job template with a limit" do
      launch_url = "#{raw_instance["url"]}launch/"
      instance_data = raw_instance.merge('ask_limit_on_launch' => true)

      expect_any_instance_of(AnsibleTowerClient::Collection).to receive(:find).with(post_result_body[:job])
      expect(api).to receive(:post).with(launch_url, json_with_limit).and_return(response_double)

      expect { described_class.new(api, instance_data).launch(json_with_limit) }.to_not raise_error
    end

    it 'checks ignorable limit' do
      subject = described_class.new(api, raw_instance.except(:ask_limit_on_launch, 'ask_limit_on_launch'))

      allow(api).to receive(:post).and_return(response_double)
      allow(AnsibleTowerClient::Collection).to receive(:find)

      expect { subject.launch(json_with_limit) }.to raise_error ArgumentError
    end
  end

  context 'override_raw_attributes' do
    let(:obj) { described_class.new(AnsibleTowerClient::MockApi.new, raw_instance) }
    let(:instance_api) { obj.instance_variable_get(:@api) }

    it 'translates :project to :project_id for update_attributes' do
      raw_instance[:project_id] = 10
      expect(instance_api).to receive(:patch).and_return(instance_double("Faraday::Result", :body => raw_instance.to_json))
      expect(obj.update_attributes(:project => '5')).to eq true
      expect(obj.project_id).to eq '5'
    end
  end
end
