describe AnsibleTowerClient::ActivityStream do
  let(:url) { "example.com/api/v1/activity_stream" }

  include_examples "Collection Methods"
  include_examples "Api Methods"
end
