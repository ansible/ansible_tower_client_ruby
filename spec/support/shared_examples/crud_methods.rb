shared_examples_for "Crud Methods" do
  it ".create posts to the api and returns the new instance" do
    expect(api).to receive(:post).and_return(instance_double("Faraday::Result", :body => raw_instance.to_json))
    expect(described_class.create(api, {:name => 'test'}.to_json)).to be_a described_class
  end
end
