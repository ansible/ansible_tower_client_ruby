describe AnsibleTowerClient::WorkflowJobTemplateNode do
  let(:url)                        { "example.com/api/v1/workflow_job_template_nodes" }
  let(:api)                        { AnsibleTowerClient::Api.new(AnsibleTowerClient::MockApi.new("1.1")) }
  let(:raw_instance)               { build(:response_instance, :workflow_job_template_node, :klass => described_class) }

  include_examples "Api Methods"

  context "#initialize" do
    it "#initialize instantiates an #{described_class} from a hash" do
      obj = api.workflow_job_template_nodes.all.first

      expect(obj).to                          be_a described_class
      expect(obj.id).to                       be_a Integer
      expect(obj.workflow_job_template_id).to be_a Integer
      expect(obj.unified_job_template_id).to  be_a Integer
      expect(obj.success_nodes_id).to         be_a Array
      expect(obj.failure_nodes_id).to         be_a Array
      expect(obj.always_nodes_id).to          be_a Array
      expect(obj.related).to                  be_a described_class::Related
    end
  end
end
