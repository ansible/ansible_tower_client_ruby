describe AnsibleTowerClient::WorkflowJobTemplate do
  let(:url)                        { "example.com/api/v1/workflow_job_templates" }
  let(:api)                        { AnsibleTowerClient::Api.new(AnsibleTowerClient::MockApi.new("1.1")) }
  let(:raw_instance)               { build(:response_instance, :workflow_job_template, :klass => described_class) }
  let(:raw_instance_no_extra_vars) { build(:response_instance, :workflow_job_template, :klass => described_class, :extra_vars => '') }
  let(:raw_instance_no_survey)     { build(:response_instance, :workflow_job_template, :klass => described_class, :related => {}) }

  include_examples "Api Methods"
  include_examples "Crud Methods"

  describe '#launch' do
    let(:json_params) { {'extra_vars' => "{\"instance_ids\":[\"i-999c\"],\"state\":\"absent\",\"subnet_id\":\"subnet-887\"}"} }
    let(:post_result_body) { {:workflow_job => 1} }

    it "runs an existing job template" do
      launch_url      = "#{raw_instance["url"]}launch/"
      response_double = instance_double("Faraday::Response", :body => post_result_body.to_json)
      expect_any_instance_of(AnsibleTowerClient::Collection).to receive(:find).with(post_result_body[:workflow_job])
      expect(api).to receive(:post).with(launch_url, json_params).and_return(response_double)

      described_class.new(api, raw_instance).launch(json_params)
    end
  end

  context "#initialize" do
    it "#initialize instantiates an #{described_class} from a hash" do
      obj = api.workflow_job_templates.all.first

      expect(obj).to             be_a described_class
      expect(obj.id).to          be_a Integer
      expect(obj.name).to        be_a String
      expect(obj.description).to be_a String
      expect(obj.related).to     be_a described_class::Related
      expect(obj.extra_vars).to  eq("{\"option\":\"lots_of_options\"}")
    end
  end

  context "#survey_spec" do
    describe "exists" do
      let(:survey_spec) { "{\"description\":\"blah\"}" }
      it "returns a survey spec" do
        expect(api).to receive(:get).and_return(instance_double("Faraday::Result", :body => survey_spec))
        expect(described_class.new(api, raw_instance).survey_spec).to eq(survey_spec)
      end
    end

    it "does not exist to return nil" do
      expect(described_class.new(api, raw_instance_no_survey).survey_spec).to be_nil
    end

    it "unlicensed to return a survey spec" do
      expect(api).to receive(:get).and_raise(AnsibleTowerClient::UnlicensedFeatureError)
      expect(described_class.new(api, raw_instance).survey_spec).to be_nil
    end
  end

  context "#survey_spec_hash" do
    describe "exists" do
      let(:survey_spec) { "{\"description\":\"blah\"}" }
      it "returns a hashed value" do
        expect(api).to receive(:get).twice.and_return(instance_double("Faraday::Result", :body => survey_spec))
        expect(described_class.new(api, raw_instance).survey_spec_hash).to eq("description" => "blah")
      end
    end

    it "does not exist to return an empty hash" do
      expect(described_class.new(api, raw_instance_no_survey).survey_spec_hash).to be_empty
      expect(described_class.new(api, raw_instance_no_survey).survey_spec_hash).to be_a_kind_of(Hash)
    end
  end

  context "#extra_vars_hash" do
    it "exists to return a hashed value" do
      obj = described_class.new(instance_double("AnsibleTowerClient::Api"), raw_instance)
      expect(obj.extra_vars_hash).to eq('option' => 'lots of options')
    end

    it "does not exist to return an empty hash" do
      obj = described_class.new(instance_double("AnsibleTowerClient::Api"), raw_instance_no_extra_vars)
      expect(obj.extra_vars_hash).to be_a_kind_of(Hash)
      expect(obj.extra_vars_hash).to be_empty
    end
  end

  # context 'override_raw_attributes' do
  #   let(:obj) { described_class.new(AnsibleTowerClient::MockApi.new, raw_instance) }
  #   let(:instance_api) { obj.instance_variable_get(:@api) }
  #
  #   it 'translates :project to :project_id for update_attributes' do
  #     raw_instance[:project_id] = 10
  #     expect(instance_api).to receive(:patch).and_return(instance_double("Faraday::Result", :body => raw_instance.to_json))
  #     expect(obj.update_attributes(:project => '5')).to eq true
  #     expect(obj.project_id).to eq '5'
  #   end
  # end
end
