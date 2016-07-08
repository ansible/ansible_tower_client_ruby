describe AnsibleTowerClient::BaseModel do
  let(:api) { double("api") }
  let(:hash) do
    {
      "name"            => "jeff",
      "address"         => { "street" => "22 charlotte rd"},
      "serialized_json" => { "key" => "value"}.to_json,
      "serialized_yaml" => { "key" => "value"}.to_yaml
    }
  end

  context ".initialize" do
    shared_examples_for "validate new object" do
      it ".new" do
        instance = described_class.new(api, json_or_hash)
        expect(instance).to                be_kind_of(described_class)
        expect(instance.name).to           eq("jeff")
        expect(instance.address).to        be_kind_of(described_class)
        expect(instance.address.street).to eq("22 charlotte rd")
      end
    end

    context "with a hash" do
      let(:json_or_hash) { hash }
      include_examples "validate new object"
    end

    context "with json" do
      let(:json_or_hash) { hash.to_json }
      include_examples "validate new object"
    end

    it "doesn't define related attributes" do
      hash_with_relations = hash.merge("host" => 1, "related" => {"host" => "http://example.com/hosts/1"})
      instance            = described_class.new(api, hash_with_relations)

      expect(instance).to_not     respond_to(:host)
      expect(instance.host_id).to eq(1)
    end
  end

  context "hashify turns a string into a hash" do
    subject { described_class.new(api, hash) }

    it "with JSON" do
      expect(subject.serialized_json).to           be_kind_of(String)
      expect(subject.hashify(:serialized_json)).to be_kind_of(Hash)
    end

    it "with YAML" do
      expect(subject.serialized_yaml).to           be_kind_of(String)
      expect(subject.hashify(:serialized_yaml)).to be_kind_of(Hash)
    end
  end
end
