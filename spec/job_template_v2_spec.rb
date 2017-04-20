describe AnsibleTowerClient::JobTemplateV2 do
  let(:url)                        { "example.com/api/v1/job_templates" }
  let(:api)                        { AnsibleTowerClient::Api.new(connection) }
  let(:connection)                 { AnsibleTowerClient::MockApi.new("2.1") }
  let(:raw_instance)               { build(:response_instance, :job_template, :klass => described_class.base_class) }
  let(:raw_instance_no_extra_vars) { build(:response_instance, :job_template, :klass => described_class.base_class, :extra_vars => '') }
  let(:raw_instance_no_survey)     { build(:response_instance, :job_template, :klass => described_class.base_class, :related => {}) }

  include_examples "Api Methods"
  include_examples "Crud Methods"
  include_examples "JobTemplate#extra_vars_hash"
  include_examples "JobTemplate#initialize"
  include_examples "JobTemplate#survey_spec"
  include_examples "JobTemplate#survey_spec_hash"

  describe '#launch' do
    let(:json) { {'extra_vars' => "{\"instance_ids\":[\"i-999c\"],\"state\":\"absent\",\"subnet_id\":\"subnet-887\"}"} }
    let(:post_result_body) { {:job => 1} }

    let(:config) { {"version" => "2.1.1"} }
    it "runs an existing job template" do
      expect_any_instance_of(AnsibleTowerClient::Collection).to receive(:find).with(post_result_body[:job])
      expect(api).to receive(:post).and_return(instance_double("Faraday::Response", :body => post_result_body.to_json))
      expect(api).to receive(:patch).twice.and_return(instance_double("Faraday::Response", :body => post_result_body.to_json))

      described_class.new(api, raw_instance).launch(json)
    end

    it "handles limit when passed in" do
      expect(connection).to receive(:patch).twice
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
      dummy = Class.new do
        def url(_)
        end

        def headers
          {}
        end

        def body=(_)
        end
      end.new
      expect(dummy).to receive(:body=).with("{ \"limit\": \"test_string\" }")
      expect(dummy).to receive(:body=).with("{ \"limit\": \"\" }")
      expect(connection).to receive(:patch).twice.and_yield(dummy)
    end
  end
end
