require 'json'

describe AnsibleTowerClient::Api do
  let(:faraday_connection) { instance_double("Faraday::Connection") }

  subject { described_class.new(faraday_connection) }

  it "#instance returns an existing instance" do
    expect(subject.instance).to be(faraday_connection)
  end

  it "#hosts returns a collection" do
    expect(subject.hosts).to be_kind_of(AnsibleTowerClient::Collection)
  end

  context "helper methods" do
    let(:config_body) do
      {:eula => 'text',
       :license_info => {:deployment_id => 'werwer', :contact_name => 'Fred Tester'},
       :version => '2.4.2', :ansible_version => '1.9.4',
       :project_local_paths => []}.to_json
    end

    let(:credentials_body) do
      {:count => 1, :next => nil, :previous => nil,
       :results => [{:id => 1, :type => 'user',
                     :url => '/api/v1/users/1',
                     :username => 'admin'}]}.to_json
    end

    let(:faraday_connection) { instance_double("Faraday::Connection", :get => get) }

    let(:api) { described_class.new(faraday_connection) }

    context "requiring a connection" do
      before { allow(Faraday).to receive(:new).and_return(faraday_connection) }

      describe "config" do
        let(:get) { instance_double("Faraday::Result", :body => config_body) }

        it "#config returns the server config" do
          json = api.config
          expect(json['eula']).to eq "text"
          expect(json['license_info']).to be_a Hash
        end

        it "#version returns the ansible tower version" do
          expect(api.version).to eq "2.4.2"
        end
      end

      describe "#verify_credentials" do
        let(:get) { instance_double("Faraday::Result", :body => credentials_body) }

        it "returns the username" do
          expect(api.verify_credentials).to eq "admin"
        end
      end
    end
  end
end
