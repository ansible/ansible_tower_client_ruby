describe AnsibleTowerClient::ActivityStream do
  let(:url)                 { "example.com/api/v1/activity_stream" }
  let(:api)                 { AnsibleTowerClient::Api.new(instance_double("Faraday::Connection")) }
  let(:collection)          { api.activity_stream }
  let(:raw_url_collection)  { build(:response_url_collection, :klass => described_class, :url => url) }
  let(:raw_instance)        { build(:response_instance, :group, :klass => described_class) }

  include_examples "Collection Methods"
  include_examples "Api Methods"
  include_examples "Instance#reload"
end
