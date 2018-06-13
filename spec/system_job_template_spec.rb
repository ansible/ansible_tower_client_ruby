describe AnsibleTowerClient::SystemJobTemplate do
  let(:api)          { AnsibleTowerClient::Api.new(AnsibleTowerClient::MockApi.new, 1) }
  let(:raw_instance) { build(:response_instance, :system_job_template, :klass => described_class) }

  describe "#launch" do
    let(:post_result_body) { {:system_job => 123} }

    it "runs a job template and returns the created system job" do
      launch_url      = "#{raw_instance["url"]}launch/"
      launch_vars     = {"days" => 10}
      response_double = instance_double("Faraday::Response", :body => post_result_body.to_json)
      expect_any_instance_of(AnsibleTowerClient::Collection).to receive(:find).with(123)
      expect(api).to receive(:post).with(launch_url, "extra_vars" => launch_vars).and_return(response_double)

      described_class.new(api, raw_instance).launch(launch_vars)
    end
  end
end
