shared_examples_for "Api Methods" do
  it "#{described_class}.endpoint is generated correctly" do
    endpoint = url.split(%r{/})[-1]
    expect(endpoint).to eq described_class.endpoint
  end
end
