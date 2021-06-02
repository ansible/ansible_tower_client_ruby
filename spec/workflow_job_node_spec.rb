describe AnsibleTowerClient::WorkflowJobNode do
  let(:url)                        { "example.com/api/v1/workflow_job_nodes" }
  let(:api)                        { AnsibleTowerClient::Api.new(AnsibleTowerClient::MockApi.new) }
  let(:raw_instance)               { build(:response_instance, :workflow_job_node, :klass => described_class) }

  include_examples "Api Methods"
  include_examples "Crud Methods"

  it "#initialize instantiates an #{described_class} from a hash" do
    obj = api.workflow_job_nodes.all.first

    expect(obj).to                    be_a described_class
    expect(obj.id).to                 be_a Integer
    expect(obj.job_id).to             be_a Integer
    expect(obj.workflow_job_id).to    be_a Integer
    expect(obj.related).to            be_a described_class::Related
  end

  context "#job" do
    def response_with_job(response, id)
      response.store_path("related", "job", id)
      response["job"] = id
      response
    end

    it "returns nil when the job_id is not set" do
      obj = described_class.new(api, raw_instance)
      expect(obj.job).to be_nil
    end

    it "returns nil when the job_id is nil" do
      obj = described_class.new(api, response_with_job(raw_instance, nil))
      expect(obj.job).to be_nil
    end

    it "returns a Job when the job_id is set" do
      obj = described_class.new(api, response_with_job(raw_instance, "/api/v1/jobs/2710/"))
      allow(api).to receive(:get).and_return(instance_double("Faraday::Result", :body => {}.to_json))

      expect(obj.job).to be_a AnsibleTowerClient::Job
    end

    it "returns a WorkflowJob when the job_id has a workflow_job" do
      obj = described_class.new(api, response_with_job(raw_instance, "/api/v1/workflow_jobs/2710/"))
      allow(api).to receive(:get).and_return(instance_double("Faraday::Result", :body => {}.to_json))

      expect(obj.job).to be_a AnsibleTowerClient::WorkflowJob
    end

    it "returns nil when it is a inventory sync" do
      obj = described_class.new(api, response_with_job(raw_instance, "/api/v1/inventory_updates/2710/"))
      allow(api).to receive(:get).and_return(instance_double("Faraday::Result", :body => {}.to_json))

      expect(obj.job).to be_nil
    end
  end
end
