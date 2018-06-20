describe AnsibleTowerClient::WorkflowJobNode do
  let(:url)                        { "example.com/api/v1/workflow_job_nodes" }
  let(:api)                        { AnsibleTowerClient::Api.new(AnsibleTowerClient::MockApi.new, 1) }
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
end
