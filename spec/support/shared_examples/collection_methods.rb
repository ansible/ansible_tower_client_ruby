shared_examples_for "Collection Methods" do
  it ".all returns an enumerator that will delay load a collection" do
    expect(collection).to receive(:find_all_by_url).with(described_class.endpoint)

    collection.all
  end

  it ".find_all_by_url returns a collection of objects via a url" do
    expect(api).to receive(:get).and_return(instance_double("Faraday::Result", :body => raw_url_collection.to_json))
    url = raw_url_collection['url']

    obj_collection = collection.find_all_by_url(url)
    expect(obj_collection).to be_a Enumerator

    obj_collection_array = obj_collection.to_a
    expect(obj_collection_array.length).to    eq(1)
    expect(obj_collection_array.first).to     be_a described_class
    expect(obj_collection_array.first.url).to eq(url)
  end

  it ".find returns an instance" do
    expect(api).to receive(:get).and_return(instance_double("Faraday::Result", :body => raw_instance.to_json))

    expect(collection.find(1)).to be_a described_class
  end
end
