describe AnsibleTowerClient::Connection do
  let(:base_options) { {:base_url => "https://example1.com", :username => "admin", :password => "smartvm", :verify_ssl => OpenSSL::SSL::VERIFY_NONE} }
  it "#initialize returns a connection instance" do
    expect(described_class.new(base_options)).to be_a AnsibleTowerClient::Connection
  end

  it ".new doesn't cache credentials across all instances" do
    conn_1 = described_class.new(base_options)
    conn_2 = described_class.new(base_options.merge(:base_url => "https://example2.com", :username => "user", :password => "password"))

    expect(conn_1.api.instance).not_to eq(conn_2.api.instance)
  end
end
