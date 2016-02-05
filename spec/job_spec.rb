require_relative 'spec_helper'

describe AnsibleTowerClient::Job do
  let(:jobs_body) do
    {:count => 2, :next => nil,
     :previous => nil,
     :results => [{:id => 1, :type => 'job',
                   :url => '/api/v1/jobs/1/', :name => 'test1'},
                  {:id => 2, :type => 'jobs',
                   :url => '/api/v1/jobs/2/', :name => 'test2'}]}.to_json
  end

  let(:one_result) do
    {:id => 1, :url => '/api/v1/jobs/1/', :name => 'test1'}.to_json
  end

  let(:api_connection) { instance_double("Faraday::Connection", :get => get) }

  describe '#Job.all' do
    let(:get) { instance_double("Faraday::Result", :body => jobs_body) }

    it "returns a list of job objects" do
      AnsibleTowerClient::Api.instance_variable_set(:@instance, api_connection)
      all_jobs = AnsibleTowerClient::Job.all
      expect(all_jobs).to        be_a Array
      expect(all_jobs.length).to eq(2)
      expect(all_jobs.first).to  be_a AnsibleTowerClient::Job
    end
  end

  describe '#initialize' do
    it "instantiates an AnsibleTowerClient::Job from a hash" do
      parsed = JSON.parse(jobs_body)['results'].first
      host = AnsibleTowerClient::Job.new(parsed)
      expect(host).to be_a AnsibleTowerClient::Job
      expect(host.id).to be_a Integer
      expect(host.name).to eq "test1"
    end
  end

  describe '#Job.find' do
    let(:get) { instance_double("Faraday::Result", :body => one_result) }

    it 'returns one record' do
      AnsibleTowerClient::Api.instance_variable_set(:@instance, api_connection)
      one_thing = AnsibleTowerClient::Job.find(1)
      expect(one_thing).to be_a AnsibleTowerClient::Job
    end
  end
end

