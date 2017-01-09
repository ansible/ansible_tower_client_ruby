shared_examples_for "Crud Methods" do
  it "described_class.create posts to the api and returns the new instance" do
    expect(api).to receive(:post).and_return(instance_double("Faraday::Result", :body => raw_instance.to_json))
    expect(described_class.create(api, {:name => 'test'}.to_json)).to be_a described_class
  end

  it ".update patches an object and returns the updated instance" do
    expect(api).to receive(:patch)
    klass_instance = described_class.new(api, raw_instance).update({:name => 'test'})
    expect(klass_instance.name).to eq 'test'
  end

  it ".delete deletes an object and returns the original object" do
    expect(api).to receive(:delete)
    klass_instance = described_class.new(api, raw_instance)
    expect(klass_instance.delete).to eq klass_instance
  end
end
