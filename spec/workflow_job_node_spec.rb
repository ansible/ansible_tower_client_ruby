describe AnsibleTowerClient::WorkflowJobNode do
  let(:url)                        { "example.com/api/v1/workflow_job_nodes" }
  let(:api)                        { AnsibleTowerClient::Api.new(AnsibleTowerClient::MockApi.new, 1) }
  let(:raw_instance)               { build(:response_instance, :workflow_job_node, :klass => described_class) }

  include_examples "Api Methods"
  include_examples "Crud Methods"

  it "#initialize instantiates an #{described_class} from a hash" do
    obj = api.workflow_job_nodes.all.to_a[1]

    expect(obj).to                    be_a described_class
    expect(obj.id).to                 be_a Integer
    expect(obj.job_id).to             be_a Integer
    expect(obj.workflow_job_id).to    be_a Integer
    expect(obj.related).to            be_a described_class::Related
  end

  it "#job returns a nil when the job_id is not set or nil" do
    obj = api.workflow_job_nodes.all.first
    expect(obj.job).to be_nil
  end

  it "#job returns a Job when the job_id is set" do
    obj = api.workflow_job_nodes.all.to_a[1]
    allow(api).to receive(:get).and_return(instance_double("Faraday::Result", :body => {}.to_json))
    expect(obj.job).to be_a AnsibleTowerClient::Job
  end
end
