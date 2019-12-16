describe AnsibleTowerClient::Api do
  let(:faraday_connection) { AnsibleTowerClient::MockApi.new("3.0.1") }

  subject { described_class.new(faraday_connection) }

  it "#instance returns an existing instance" do
    expect(subject.instance).to be(faraday_connection)
  end

  it "#hosts returns a collection" do
    expect(subject.hosts).to be_kind_of(AnsibleTowerClient::Collection)
  end

  context "helper methods" do
    context "requiring a connection" do
      describe "config" do
        it "#config returns the server config" do
          json = subject.config
          expect(json['eula']).to eq "text"
          expect(json['license_info']).to be_a Hash
        end

        it "#version returns the ansible tower version" do
          expect(subject.version).to eq "3.0.1"
        end
      end

      describe "#verify_credentials" do
        let(:get) { instance_double("Faraday::Result", :body => credentials_body) }

        it "returns the username" do
          expect(subject.verify_credentials).to eq "admin"
        end
      end

      describe "#method_missing" do
        let(:plain_response_body) { "some response" }
        let(:json_response_body) { { "some_key" => "some_value" } }
        let(:path_to_resource) { 'some/path' }

        it "logs method call with formatted JSON response body" do
          expect(subject).to receive(:build_path_to_resource).and_return(path_to_resource)

          connection_response = instance_double("Faraday::Response", :body => json_response_body.to_json)
          expect(faraday_connection).to receive(:get).and_return(connection_response)

          expect(AnsibleTowerClient.logger).to receive(:debug) do |&block|
            expect(block.call).to eq("AnsibleTowerClient::Api Sending <get> with <#{[path_to_resource].inspect}>")
          end
          expect(AnsibleTowerClient.logger).to receive(:debug) do |&block|
            expect(block.call).to eq("AnsibleTowerClient::Api Response:\n#{json_response_body.pretty_inspect}")
          end

          subject.get
        end

        it "logs method call with plain text response body" do
          expect(subject).to receive(:build_path_to_resource).and_return(path_to_resource)

          connection_response = instance_double("Faraday::Response", :body => plain_response_body)
          expect(faraday_connection).to receive(:get).and_return(connection_response)

          expect(AnsibleTowerClient.logger).to receive(:debug) do |&block|
            expect(block.call).to eq("AnsibleTowerClient::Api Sending <get> with <#{[path_to_resource].inspect}>")
          end
          expect(AnsibleTowerClient.logger).to receive(:debug) do |&block|
            expect(block.call).to eq("AnsibleTowerClient::Api Response:\n#{plain_response_body}")
          end

          subject.get
        end

        it "raises actual error, not NameError" do
          error = 'some error'
          expect(faraday_connection).to receive(:get).and_raise(error)
          expect { subject.get }.to raise_error(error)
        end
      end
    end
  end

  context "private methods" do
    context "#build_path_to_resource" do
      {
        "/" => {
          "/api/v1/hosts"         => "/api/v1/hosts",
          "/api/v1/hosts/"        => "/api/v1/hosts/",
          "/api/v1/hosts/5"       => "/api/v1/hosts/5",
          "/api/v1/hosts/5/"      => "/api/v1/hosts/5/",
          "/api/v1/hosts?page=2"  => "/api/v1/hosts?page=2",
          "/api/v1/hosts/?page=2" => "/api/v1/hosts/?page=2",
        },
        "/api/v1" => {
          "/api/v1/hosts"         => "/api/v1/hosts",
          "/api/v1/hosts/"        => "/api/v1/hosts/",
          "/api/v1/hosts/5"       => "/api/v1/hosts/5",
          "/api/v1/hosts/5/"      => "/api/v1/hosts/5/",
          "/api/v1/hosts?page=2"  => "/api/v1/hosts?page=2",
          "/api/v1/hosts/?page=2" => "/api/v1/hosts/?page=2",
        },
        "/api/v2" => {
          "/api/v1/hosts"         => "/api/v2/hosts",
          "/api/v1/hosts/"        => "/api/v2/hosts/",
          "/api/v1/hosts/5"       => "/api/v2/hosts/5",
          "/api/v1/hosts/5/"      => "/api/v2/hosts/5/",
          "/api/v1/hosts?page=2"  => "/api/v2/hosts?page=2",
          "/api/v1/hosts/?page=2" => "/api/v2/hosts/?page=2",
        },
        "/tower" => {
          "/api/v1/hosts"         => "/tower/hosts",
          "/api/v1/hosts/"        => "/tower/hosts/",
          "/api/v1/hosts/5"       => "/tower/hosts/5",
          "/api/v1/hosts/5/"      => "/tower/hosts/5/",
          "/api/v1/hosts?page=2"  => "/tower/hosts?page=2",
          "/api/v1/hosts/?page=2" => "/tower/hosts/?page=2",
        },
        "/nested/more/than/necessary" => {
          "/api/v1/hosts"         => "/nested/more/than/necessary/hosts",
          "/api/v1/hosts/"        => "/nested/more/than/necessary/hosts/",
          "/api/v1/hosts/5"       => "/nested/more/than/necessary/hosts/5",
          "/api/v1/hosts/5/"      => "/nested/more/than/necessary/hosts/5/",
          "/api/v1/hosts?page=2"  => "/nested/more/than/necessary/hosts?page=2",
          "/api/v1/hosts/?page=2" => "/nested/more/than/necessary/hosts/?page=2",
        },
      }.each do |path, matrix|
        it "connection path #{path}" do
          url = "https://server.example.com:8080#{path}"
          connection = AnsibleTowerClient::Connection.new(:username => "user", :password => "pass", :base_url => url)
          api = connection.api

          matrix.each do |default_path, corrected_path|
            expect(api.send(:build_path_to_resource, default_path)).to eq(corrected_path)
          end
        end
      end
    end
  end
end
