shared_examples_for "Crud Methods" do
  context "#{described_class}.create" do
    it "posts to the api and returns the new instance" do
      expect(api).to receive(:post).and_return(instance_double("Faraday::Result", :body => raw_instance.to_json))
      expect(described_class.create(api, {:name => 'test'}.to_json)).to be_a described_class
    end
  end

  context "#{described_class}.create!" do
    it "posts to the api and returns an error if one is raised" do
      expect(api).to receive(:post).and_raise(AnsibleTowerClient::Error, 'error')
      expect { described_class.create!(api, :name => 'bad test') }.to raise_error(AnsibleTowerClient::Error)
    end
  end

  context "#{described_class} instance method CRUD" do
    let(:obj) { described_class.new(instance_double("Faraday::Connection"), raw_instance) }
    let(:instance_api) { obj.instance_variable_get(:@api) }

    context ".update_attributes" do
      it "accepts a hash and returns true if no errors are raised" do
        expect(instance_api).to receive(:patch).and_return(instance_double("Faraday::Result", :body => raw_instance.to_json))
        expect(obj.update_attributes(:name => 'blah')).to eq true
        expect(obj.name).to eq 'blah'
      end

      it "returns false if an error is raised" do
        expect(instance_api).to receive(:patch).and_raise(AnsibleTowerClient::Error, 'error')
        expect(obj.update_attributes(:name => 'bad name')).to eq false
      end
    end

    context ".update_attributes!" do
      it "accepts a hash and returns true if no errors are raised" do
        expect(instance_api).to receive(:patch).and_return(instance_double("Faraday::Result", :body => raw_instance.to_json))
        expect(obj.update_attributes!(:name => 'blah')).to eq true
        expect(obj.name).to eq 'blah'
      end

      it "ignore unknown attributes if patch succeeds" do
        expect(instance_api).to receive(:patch).and_return(instance_double("Faraday::Result", :body => raw_instance.to_json))
        expect(obj.update_attributes!(:name => 'blah', :stranger_thing => 'bomb')).to eq true
        expect(obj.name).to eq 'blah'
      end

      it "returns an error if an error is raised" do
        expect(instance_api).to receive(:patch).and_raise(AnsibleTowerClient::Error, 'error')
        expect { obj.update_attributes!(:name => 'bad name') }.to raise_error(AnsibleTowerClient::Error)
      end
    end

    context ".save" do
      it "returns true if no errors are raised" do
        expect(instance_api).to receive(:patch).and_return(instance_double("Faraday::Result", :body => raw_instance.to_json))
        obj.name = 'blah'
        expect(obj.save).to eq true
        expect(obj.name).to eq 'blah'
      end

      it "returns false if an error is raised" do
        expect(instance_api).to receive(:patch).and_raise(AnsibleTowerClient::Error, 'error')
        obj.name = 'bad name'
        expect(obj.save).to eq false
      end
    end

    context ".save!" do
      it "returns true if no errors are raised" do
        expect(instance_api).to receive(:patch).and_return(instance_double("Faraday::Result", :body => raw_instance.to_json))
        obj.name = 'blah'
        expect(obj.save!).to eq true
        expect(obj.name).to eq 'blah'
      end

      it "returns an error if an error is raised" do
        expect(instance_api).to receive(:patch).and_raise(AnsibleTowerClient::Error, 'error')
        obj.name = 'bad name'
        expect { obj.save! }.to raise_error(AnsibleTowerClient::Error)
      end
    end

    context ".destroy!" do
      it "deletes a record and returns the original object" do
        expect(instance_api).to receive(:delete).and_return(obj)
        expect(obj.destroy!).to eq obj
      end

      it "returns an error if an error is raised" do
        expect(instance_api).to receive(:delete).and_raise(AnsibleTowerClient::Error, 'error')
        expect { obj.destroy! }.to raise_error(AnsibleTowerClient::Error)
      end
    end

    context ".destroy" do
      it "deletes a record and returns the original object" do
        expect(instance_api).to receive(:delete).and_return(obj)
        expect(obj.destroy!).to eq obj
      end

      it "returns false if an error is raised" do
        expect(instance_api).to receive(:delete).and_raise(AnsibleTowerClient::Error, 'error')
        expect(obj.destroy).to eq false
      end
    end
  end
end
