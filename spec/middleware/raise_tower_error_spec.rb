
require 'faraday'
require 'ansible_tower_client/middleware/raise_tower_error'
require_relative '../spec_helper'

describe AnsibleTowerClient::Middleware::RaiseTowerError do
  context "Faraday::Error" do
    let(:env_400) { MockEnv.new('missing these attributes', 400) }
    let(:env_402) { MockEnv.new('missing these attributes', 402) }
    let(:env_404) { MockEnv.new('missing these attributes', 404) }
    let(:env_407) { MockEnv.new('missing these attributes', 407) }

    let(:error) { AnsibleTowerClient::Middleware::RaiseTowerError.new }

    around do |example|
      AnsibleTowerClient.logger.level = 0
      example.run
      AnsibleTowerClient.logger.level = 1
    end

    it "raises ClientError and returns the body message with a status 400" do
      expect(AnsibleTowerClient.logger).to receive(:debug) do |&block|
        expect(block.call).to eq("#{described_class.name} Raw Response:\n#{env_400.pretty_inspect}")
      end
      expect(AnsibleTowerClient.logger).to receive(:error).with(
        "AnsibleTowerClient::Middleware::RaiseTowerError Response Body:\nmissing these attributes"
      )
      expect { error.on_complete(env_400) }.to raise_error(AnsibleTowerClient::ClientError, "missing these attributes")
    end

    it "raises UnlicensedFeatureError with a status 402" do
      expect(AnsibleTowerClient.logger).to receive(:debug) do |&block|
        expect(block.call).to eq("#{described_class.name} Raw Response:\n#{env_402.pretty_inspect}")
      end
      expect(AnsibleTowerClient.logger).to receive(:error).with(
        "AnsibleTowerClient::Middleware::RaiseTowerError Response Body:\nmissing these attributes"
      )
      expect { error.on_complete(env_402) }.to raise_error(AnsibleTowerClient::UnlicensedFeatureError)
    end

    it "raises ResourceNotFound exception with a status 404" do
      expect(AnsibleTowerClient.logger).to receive(:debug) do |&block|
        expect(block.call).to eq("#{described_class.name} Raw Response:\n#{env_404.pretty_inspect}")
      end
      expect(AnsibleTowerClient.logger).to receive(:error).with(
        "AnsibleTowerClient::Middleware::RaiseTowerError Response Body:\nmissing these attributes"
      )
      expect { error.on_complete(env_404) }.to raise_error(AnsibleTowerClient::ResourceNotFoundError)
    end

    it "raises ConnectionFailed exception with a status 407" do
      expect(AnsibleTowerClient.logger).to receive(:debug) do |&block|
        expect(block.call).to eq("#{described_class.name} Raw Response:\n#{env_407.pretty_inspect}")
      end
      expect(AnsibleTowerClient.logger).to receive(:error).with(
        "AnsibleTowerClient::Middleware::RaiseTowerError Response Body:\nmissing these attributes"
      )
      expect { error.on_complete(env_407) }.to raise_error(AnsibleTowerClient::ConnectionError)
    end
  end
end

class MockEnv < Struct.new(:body, :status, :response_headers); end
