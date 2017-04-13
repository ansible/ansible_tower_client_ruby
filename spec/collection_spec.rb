describe AnsibleTowerClient::Collection do
  let(:connection)  { double("connection") }
  let(:mock_api)    { AnsibleTowerClient::Api.new(connection) }
  let(:instance)    { described_class.new(mock_api) }
  let(:test_url)    { "/api/v1/things/1/related_things/" }
  let(:get_options) { {"key" => "value"} }
  let(:response_1)  { double("response", :body => body_1) }
  let(:body_1)      { {"next_page" => nil, "results" => (1..5).collect { |i| {:id => i, :type => "host"} }}.to_json }

  context "#find_all_by_url" do
    it "is an Enumerator" do
      expect(instance.find_all_by_url(test_url)).to be_kind_of(Enumerator)
    end

    it "ensures all get_options are applied to all requests" do
      expect(mock_api).to receive(:get).with(anything, get_options).twice.and_return(response_1)

      collection = instance.find_all_by_url(test_url, get_options)
      expect(collection.count).to eq(5)
      expect(collection.count).to eq(5)
    end
  end
end
