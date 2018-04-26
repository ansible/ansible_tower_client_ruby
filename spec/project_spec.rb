describe AnsibleTowerClient::Project do
  let(:url)          { "example.com/api/v1/projects" }
  let(:api)          { AnsibleTowerClient::Api.new(AnsibleTowerClient::MockApi.new) }
  let(:raw_instance) { build(:response_instance, :project, :klass => described_class) }

  include_examples "Api Methods"
  include_examples "Crud Methods"

  it "#initialize instantiates an #{described_class} from a hash" do
    obj = api.projects.all.first

    expect(obj).to                 be_a(described_class)
    expect(obj.id).to              be_a(Integer)
    expect(obj.url).to             be_a(String)
    expect(obj.organization_id).to be_a(Integer)
    expect(obj.description).to     be_a(String)
    expect(obj.name).to            be_a(String)
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

  describe '#last_update' do
    let(:project_update) { AnsibleTowerClient::ProjectUpdate.new(api, 'id' => 123) }

    it "fetches last update" do
      collection_double = instance_double("AnsibleTowerClient::Collection")
      expect(api).to receive(:project_updates).and_return(collection_double)
      expect(collection_double).to receive(:find).with(raw_instance['related']['last_update']).and_return(project_update)
      actual_instance = described_class.new(api, raw_instance).last_update
      expect(actual_instance).to equal(project_update)
    end

    it "does not fetch last update if missing" do
      raw_instance['related'].delete('last_update')
      result = described_class.new(api, raw_instance).last_update
      expect(result).to be_nil
    end

    it "does not fetch last update if nil" do
      raw_instance['related']['last_update'] = nil
      result = described_class.new(api, raw_instance).last_update
      expect(result).to be_nil
    end
  end
end
