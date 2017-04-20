describe AnsibleTowerClient::JobEvent do
  let(:url)                 { "example.com/api/v1/job_events" }
  let(:api)                 { AnsibleTowerClient::Api.new(instance_double("Faraday::Connection")) }
  let(:collection)          { api.job_events }
  let(:raw_url_collection)  { build(:response_url_collection, :klass => described_class, :url => url) }
  let(:raw_instance)        { build(:response_instance, :job_event, :klass => described_class) }

  include_examples "Api Methods"
end
