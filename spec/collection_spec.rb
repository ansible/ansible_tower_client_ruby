describe AnsibleTowerClient::Collection do
  COLLECTION_CLASSES = [
    AnsibleTowerClient::AdHocCommand,
    AnsibleTowerClient::Credential,
    AnsibleTowerClient::Group,
    AnsibleTowerClient::Host,
    AnsibleTowerClient::Inventory,
    AnsibleTowerClient::InventorySource,
    AnsibleTowerClient::InventoryUpdate,
    AnsibleTowerClient::Job,
    AnsibleTowerClient::JobEvent,
    AnsibleTowerClient::JobTemplate,
    AnsibleTowerClient::Organization,
    AnsibleTowerClient::Project,
    AnsibleTowerClient::ProjectUpdate,
  ].freeze

  let(:connection)  { double("connection") }
  let(:mock_api)    { AnsibleTowerClient::Api.new(connection).tap { |a| a.instance_variable_set(:@version, "1.1") } }
  let(:instance)    { described_class.new(mock_api) }
  let(:test_url)    { "/api/v1/things/1/related_things/" }
  let(:get_options) { {"key" => "value"} }
  let(:response_1)  { double("response", :body => body_1) }
  let(:body_1)      { {"next_page" => nil, "results" => (1..5).collect { |i| {:id => i, :type => "host"} }}.to_json }

  context "#all returns an enumerator that will delay load a collection" do
    COLLECTION_CLASSES.each do |klass|
      it "for #{klass}" do
        klass_name = klass.name.split("::").last
        collection_class = klass_name.underscore.pluralize

        allow(mock_api).to receive(:config).and_return({}) # For Job Template class
        collection = described_class.new(mock_api, klass)
        expect(described_class).to receive(:new).with(mock_api, klass).and_return(collection)
        expect(collection).to receive(:find_all_by_url).with(klass.endpoint, any_args)

        mock_api.send(collection_class).all
      end
    end
  end

  context "#find" do
    COLLECTION_CLASSES.each do |klass|
      it "for #{klass}" do
        klass_name = klass.name.split("::").last
        collection_class = klass_name.underscore.pluralize

        allow(mock_api).to receive(:config).and_return({}) # For Job Template class
        expect(mock_api).to receive(:get).and_return(instance_double("Faraday::Result", :body => {}.to_json))

        expect(mock_api.send(collection_class).find(1)).to be_instance_of(klass)
      end
    end
  end

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

    context "Private Methods" do
      context "#parse_result_set" do
        it "with an Array response" do
          array = [1, 2, 3, "a", "b", "c"]
          response = double("response", :body => array.to_json)
          expect(mock_api).to receive(:get).with("abc", nil).and_return(response)

          expect(described_class.new(mock_api).find_all_by_url("abc").collect { |i| i }).to eq(array)
        end

        it "with a paginated collection response" do
          body = {
            "count"    => 2,
            "next"     => nil,
            "previous" => nil,
            "results"  => [
              {:a => 1, "type" => "host"},
              {:b => 2, "type" => "host"},
            ]
          }
          response = double("response", :body => body.to_json)
          expect(mock_api).to receive(:get).with("abc", nil).and_return(response)

          array = described_class.new(mock_api).find_all_by_url("abc").to_a
          expect(array.length).to eq(2)
          expect(array.first).to have_attributes(:a => 1, :type => "host")
          expect(array.last).to have_attributes(:b => 2, :type => "host")
        end
      end
    end
  end
end
