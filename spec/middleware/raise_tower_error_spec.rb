require 'faraday'
require 'ansible_tower_client/middleware/raise_tower_error'
require_relative '../spec_helper'

describe AnsibleTowerClient::Middleware::RaiseTowerError do
  context "Faraday::Error" do
    let(:env_400) { MockEnv.new('missing these attributes', 400) }
    let(:env_404) { MockEnv.new('missing these attributes', 404) }
    let(:env_407) { MockEnv.new('missing these attributes', 407) }

    let(:error) { AnsibleTowerClient::Middleware::RaiseTowerError.new }

    it "raises ClientError and returns the body message with a status 404" do
      expect { error.on_complete(env_400) }.to raise_error(AnsibleTowerClient::ClientError, "missing these attributes")
    end

    it "raises ResourceNotFound exception with a status 404" do
      expect { error.on_complete(env_404) }.to raise_error(Faraday::Error::ResourceNotFound)
    end

    it "raises ConnectionFailed exception with a status 407" do
      expect { error.on_complete(env_407) }.to raise_error(Faraday::Error::ConnectionFailed)
    end
  end
end

class MockEnv < Struct.new(:body, :status, :response_headers); end
