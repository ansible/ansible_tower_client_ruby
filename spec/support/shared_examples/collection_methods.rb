shared_examples_for "Collection Methods" do
  it ".all returns a collection of objects" do
    expect(api).to receive(:get).and_return(instance_double("Faraday::Result", :body => raw_collection.to_json))

    obj_collection = collection.all
    expect(obj_collection).to        be_a Array
    expect(obj_collection.length).to eq(2)
    expect(obj_collection.first).to  be_a described_class
  end

  it ".find returns an instance" do
    expect(api).to receive(:get).at_least(:once).and_return(instance_double("Faraday::Result", :body => raw_instance.to_json))

    expect(collection.find(1)).to be_a described_class
    attrs = described_class.const_get('EXCLUDED')
    if attrs.present?
      hashed_attribute = collection.find(1)[attrs.first]
      expect(hashed_attribute.present?).to be true
      expect(hashed_attribute).to be_a Hash
    end
  end
end
