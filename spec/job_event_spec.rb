describe AnsibleTowerClient::JobEvent do
  let(:url) { "example.com/api/v1/job_events" }
  let(:api) { AnsibleTowerClient::Api.new(AnsibleTowerClient::MockApi.new, 1) }

  include_examples "Api Methods"
end
