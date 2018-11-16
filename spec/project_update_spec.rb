describe AnsibleTowerClient::ProjectUpdate do
  let(:url)                 { "example.com/api/v1/project_updates" }
  let(:api)                 { AnsibleTowerClient::Api.new(instance_double("Faraday::Connection")) }
  let(:collection)          { api.project_updates }
  let(:raw_collection)      { build(:response_collection, :klass => described_class) }
  let(:raw_url_collection)  { build(:response_url_collection, :klass => described_class, :url => url) }
  let(:raw_instance)        { build(:response_instance, :klass => described_class) }

  include_examples "Api Methods"

  it "#initialize instantiates an #{described_class} from a hash" do
    obj = described_class.new(instance_double("AnsibleTowerClient::Api"), raw_instance)

    expect(obj).to      be_a described_class
    expect(obj.id).to   be_a Integer
    expect(obj.name).to be_a String
  end

  context '#stdout' do
    describe "exists" do
      let(:stdout) { "Ansible Tower Project Update output" }

      it "returns stdout default to plain text" do
        expect(api).to receive(:get).with(/format=txt/).and_return(instance_double("Faraday::Result", :body => stdout))
        expect(described_class.new(api, raw_instance).stdout).to eq(stdout)
      end

      it "returns formatted text per request" do
        expect(api).to receive(:get).with(/format=html/).and_return(instance_double("Faraday::Result", :body => stdout))
        expect(described_class.new(api, raw_instance).stdout('html')).to eq(stdout)
      end
    end
  end
end
