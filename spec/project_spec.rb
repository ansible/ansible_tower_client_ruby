describe AnsibleTowerClient::Project do
  let(:url)          { "example.com/api/v1/projects" }
  let(:api)          { AnsibleTowerClient::Api.new(AnsibleTowerClient::MockApi.new) }
  let(:raw_instance) { build(:response_instance, :project, :klass => described_class) }

  include_examples "Api Methods"
  include_examples "Crud Methods"

  it "#initialize instantiates an #{described_class} from a hash" do
    obj = api.projects.all.first

    expect(obj).to              be_a described_class
    expect(obj.id).to           be_a Integer
    expect(obj.url).to          be_a String
    expect(obj.organization).to be_a Integer
    expect(obj.description).to  be_a String
    expect(obj.name).to         be_a String
  end

  describe '#can_update?' do
    let(:can_update_true)   { {'can_update' => true}  }
    let(:can_update_false)  { {'can_update' => false} }

    it 'returns true' do
      expect(api).to receive(:get).and_return(instance_double("Faraday::Response", :body => can_update_true.to_json))
      expect(described_class.new(api, raw_instance).can_update?).to be_truthy
    end

    it 'returns false' do
      expect(api).to receive(:get).and_return(instance_double("Faraday::Response", :body => can_update_false.to_json))
      expect(described_class.new(api, raw_instance).can_update?).to be_falsey
    end
  end

  describe '#update' do
    let(:post_result_body) { {:inventory_update => 1} }

    it "updates an inventory_source" do
      expect_any_instance_of(AnsibleTowerClient::Collection).to receive(:find).with(post_result_body[:project_update])
      expect(api).to receive(:post).and_return(instance_double("Faraday::Response", :body => post_result_body.to_json))

      described_class.new(api, raw_instance).update
    end
  end
end
