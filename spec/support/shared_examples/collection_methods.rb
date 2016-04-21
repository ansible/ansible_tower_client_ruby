shared_examples_for "Collection Methods" do
  it ".all returns a collection of objects" do
    expect(api).to receive(:get).and_return(instance_double("Faraday::Result", :body => raw_collection.to_json))

    obj_collection = collection.all
    expect(obj_collection).to        be_a Array
    expect(obj_collection.length).to eq(2)
    expect(obj_collection.first).to  be_a described_class
  end

  it ".find_all_by_url returns a collection of objects via a url" do
    expect(api).to receive(:get).and_return(instance_double("Faraday::Result", :body => raw_url_collection.to_json))
    url = raw_url_collection['url']

    obj_collection = collection.find_all_by_url(url)
    expect(obj_collection).to        be_a Array
    expect(obj_collection.length).to eq(1)
    expect(obj_collection.first).to  be_a described_class
    expect(obj_collection.first.url).to eq url
  end

  it ".find returns an instance" do
    expect(api).to receive(:get).and_return(instance_double("Faraday::Result", :body => raw_instance.to_json))

    expect(collection.find(1)).to be_a described_class
  end
end
