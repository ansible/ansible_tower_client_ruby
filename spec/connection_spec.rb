describe AnsibleTowerClient::Connection do
  let(:logger)       { double }
  let(:base_options) { {:base_url => "https://example1.com", :username => "admin", :password => "smartvm", :verify_ssl => OpenSSL::SSL::VERIFY_NONE, :logger => logger} }

  subject { described_class.new(base_options) }

  it "#initialize returns a connection instance" do
    expect(described_class.new(base_options)).to be_a AnsibleTowerClient::Connection
  end

  it "#initialize sets options" do
    expect(subject.options).to eq(
      :url        => "https://example1.com",
      :verify_ssl => false,
      :username   => "admin",
      :password   => "smartvm",
      :logger     => logger,
    )
  end

  it ".new doesn't cache credentials across all instances" do
    conn_1 = described_class.new(base_options)
    conn_2 = described_class.new(base_options.merge(:base_url => "https://example2.com", :username => "user", :password => "password"))

    expect(conn_1.api.instance).not_to eq(conn_2.api.instance)
  end

  context ".api" do
    it "defaults to api v1" do
      expect(subject.api.api_version).to eq(1)
    end

    it "supports api v1" do
      expect(subject.api(:version => 1).api_version).to eq(1)
    end

    it "dynamic switching between v1 and v2 won't interfere" do
      expect(subject.api(:version => 1).api_version).to eq(1)
      expect(subject.api(:version => 2).api_version).to eq(2)
      expect(subject.api(:version => 1).api_version).to eq(1)
      expect(subject.api(:version => 2).api_version).to eq(2)
    end
  end

  context ".url_path_for_version" do
    [
      {
        :case            => "basic base url",
        :base_url        => "",
        :expected_url_v1 => "/api/v1",
        :expected_url_v2 => "/api/v2"
      },
      {
        :case            => "hash-ended base url",
        :base_url        => "/",
        :expected_url_v1 => "/api/v1",
        :expected_url_v2 => "/api/v2"
      },
      {
        :case            => "custom base url",
        :base_url        => "/custom/api/path",
        :expected_url_v1 => "/custom/api/path",
        :expected_url_v2 => "/custom/api/path"
      }
    ].each do |args|
      it args[:case].to_s do
        expect(subject.send(:url_path_for_version, args[:base_url], 1)).to eq(args[:expected_url_v1])
        expect(subject.send(:url_path_for_version, args[:base_url], 2)).to eq(args[:expected_url_v2])
      end
    end
  end
end
