require 'faraday'
require 'ansible_tower_client/middleware/raise_tower_error'

describe AnsibleTowerClient::Middleware::RaiseTowerError do
  context "Faraday::Error" do
    let(:message) { 'missing these attributes' }

    let(:env_400) { MockEnv.new(message, 400) }
    let(:env_402) { MockEnv.new(message, 402) }
    let(:env_404) { MockEnv.new(message, 404) }
    let(:env_407) { MockEnv.new(message, 407) }

    let(:obj) { {'error' => message} }
    let(:env_json) { MockEnv.new(obj.to_json, 400) }

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
        "AnsibleTowerClient::Middleware::RaiseTowerError Response Body:\n#{env_400.body}"
      )
      expect { error.on_complete(env_400) }.to raise_error(AnsibleTowerClient::ClientError, message)
    end

    it "raises UnlicensedFeatureError with a status 402" do
      expect(AnsibleTowerClient.logger).to receive(:debug) do |&block|
        expect(block.call).to eq("#{described_class.name} Raw Response:\n#{env_402.pretty_inspect}")
      end
      expect(AnsibleTowerClient.logger).to receive(:error).with(
        "AnsibleTowerClient::Middleware::RaiseTowerError Response Body:\n#{env_402.body}"
      )
      expect { error.on_complete(env_402) }.to raise_error(AnsibleTowerClient::UnlicensedFeatureError)
    end

    it "raises ResourceNotFound exception with a status 404" do
      expect(AnsibleTowerClient.logger).to receive(:debug) do |&block|
        expect(block.call).to eq("#{described_class.name} Raw Response:\n#{env_404.pretty_inspect}")
      end
      expect(AnsibleTowerClient.logger).to receive(:error).with(
        "AnsibleTowerClient::Middleware::RaiseTowerError Response Body:\n#{env_404.body}"
      )
      expect { error.on_complete(env_404) }.to raise_error(AnsibleTowerClient::ResourceNotFoundError)
    end

    it "raises ConnectionFailed exception with a status 407" do
      expect(AnsibleTowerClient.logger).to receive(:debug) do |&block|
        expect(block.call).to eq("#{described_class.name} Raw Response:\n#{env_407.pretty_inspect}")
      end
      expect(AnsibleTowerClient.logger).to receive(:error).with(
        "AnsibleTowerClient::Middleware::RaiseTowerError Response Body:\n#{env_407.body}"
      )
      expect { error.on_complete(env_407) }.to raise_error(AnsibleTowerClient::ConnectionError)
    end

    it "logs error with formatted JSON response body" do
      expect(AnsibleTowerClient.logger).to receive(:error).with(
        "AnsibleTowerClient::Middleware::RaiseTowerError Response Body:\n#{obj.pretty_inspect}"
      )
      expect { error.on_complete(env_json) }.to raise_error(AnsibleTowerClient::ClientError)
    end
  end
end

class MockEnv < Struct.new(:body, :status, :response_headers); end
