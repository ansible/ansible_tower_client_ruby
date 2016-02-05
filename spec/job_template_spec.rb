require_relative 'spec_helper'

describe AnsibleTowerClient::JobTemplate do
  let(:job_templates_body) do
    {:count => 2, :next => nil,
     :previous => nil,
     :results => [{:id => 1, :type => 'job_template',
                   :url => '/api/v1/job_templates/1/', :name => 'test1', :description => 'description1'},
                  {:id => 2, :type => 'job_templates',
                   :url => '/api/v1/job_templates/2/', :name => 'test2', :description => 'description2'}]}.to_json
  end

  let(:one_result) do
    {:id => 1, :url => '/api/v1/job_templates/1/', :name => 'test1',
     :extra_vars => 'blah', :description => 'description1'}.to_json
  end

  let(:post_result_body) do
    {:job => 1}.to_json
  end

  let(:post) { instance_double("Faraday::Response", :body => post_result_body) }

  let(:api_connection) { instance_double("Faraday::Connection", :get => get, :post => post) }

  describe '#JobTemplate.all' do
    let(:get) { instance_double("Faraday::Result", :body => job_templates_body) }

    it "returns a list of job_template objects" do
      AnsibleTowerClient::Api.instance_variable_set(:@instance, api_connection)
      all_job_templates = AnsibleTowerClient::JobTemplate.all
      expect(all_job_templates).to        be_a Array
      expect(all_job_templates.length).to eq(2)
      expect(all_job_templates.first).to  be_a AnsibleTowerClient::JobTemplate
    end
  end

  describe '#initialize' do
    it "instantiates an AnsibleTowerClient::JobTemplate from a hash" do
      parsed = JSON.parse(job_templates_body)['results'].first
      host = AnsibleTowerClient::JobTemplate.new(parsed)
      expect(host).to             be_a AnsibleTowerClient::JobTemplate
      expect(host.id).to          be_a Integer
      expect(host.name).to        eq "test1"
      expect(host.description).to eq "description1"
    end
  end

  describe '#launch' do
    let(:get) { instance_double("Faraday::Result", :body => one_result) }
    let(:json) do
      "{\"instance_ids\":[\"i-999c\"],\"region\":\"us-99\",\"state\":\"absent\",\"subnet_id\":\"subnet-887\"}"
    end

    it "runs an existing job template" do
      AnsibleTowerClient::Api.instance_variable_set(:@instance, api_connection)
      parsed = JSON.parse(job_templates_body)['results'].first
      host = AnsibleTowerClient::JobTemplate.new(parsed)
      resp = host.launch(json)
      expect(resp).to be_a AnsibleTowerClient::Job
      expect(resp.id).to eq 1
    end
  end

  describe '#extra_vars' do
    let(:get) { instance_double("Faraday::Result", :body => one_result) }

    it 'displays extra_vars on a job template' do
      AnsibleTowerClient::Api.instance_variable_set(:@instance, api_connection)
      one_thing = AnsibleTowerClient::JobTemplate.find(1)
      expect(one_thing.extra_vars).to be_a String
      expect(one_thing.extra_vars).to eq "blah"
    end
  end

  describe '#JobTemplate.find' do
    let(:get) { instance_double("Faraday::Result", :body => one_result) }

    it 'returns one record' do
      AnsibleTowerClient::Api.instance_variable_set(:@instance, api_connection)
      one_thing = AnsibleTowerClient::JobTemplate.find(1)
      expect(one_thing).to be_a AnsibleTowerClient::JobTemplate
    end
  end
end

