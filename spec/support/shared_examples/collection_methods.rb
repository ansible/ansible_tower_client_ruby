shared_examples_for "Collection Methods" do
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

  it ".find_all_by_url returns a collection of items via a url" do
    raw_collection_array = raw_url_collection.to_a.flatten
    expect(api).to receive(:get).and_return(instance_double("Faraday::Result", :body => raw_collection_array.to_json))
    url = raw_url_collection['url']

    obj_collection = collection.find_all_by_url(url)
    expect(obj_collection).to be_a Enumerator

    obj_collection_array = obj_collection.to_a
    expect(obj_collection_array.length).to    eq(8)
    expect(obj_collection_array.first).to_not eq described_class
    expect(obj_collection_array.first).to be_a String
  end
end
