shared_examples_for "JobTemplate#initialize" do
  it "#initialize instantiates an #{described_class} from a hash" do
    obj = api.job_templates.all.first

    expect(obj).to             be_a described_class
    expect(obj.id).to          be_a Integer
    expect(obj.name).to        be_a String
    expect(obj.description).to be_a String
    expect(obj.related).to     be_a described_class::Related
    expect(obj.extra_vars).to  eq("{\"option\":\"lots_of_options\"}")
  end
end

shared_examples_for "JobTemplate#survey_spec" do
  describe "exists" do
    let(:survey_spec) { "{\"description\":\"blah\"}" }
    it "returns a survey spec" do
      expect(api).to receive(:get).and_return(instance_double("Faraday::Result", :body => survey_spec))
      expect(described_class.new(api, raw_instance).survey_spec).to eq(survey_spec)
    end
  end

  describe "does not exist" do
    it "returns nil" do
      expect(described_class.new(api, raw_instance_no_survey).survey_spec).to be_nil
    end
  end

  describe "unlicensed" do
    it "returns a survey spec" do
      expect(api).to receive(:get).and_raise(AnsibleTowerClient::UnlicensedFeatureError)
      expect(described_class.new(api, raw_instance).survey_spec).to be_nil
    end
  end
end

shared_examples_for "JobTemplate#survey_spec_hash" do
  describe "exists" do
    let(:survey_spec) { "{\"description\":\"blah\"}" }
    it "returns a hashed value" do
      expect(api).to receive(:get).twice.and_return(instance_double("Faraday::Result", :body => survey_spec))
      expect(described_class.new(api, raw_instance).survey_spec_hash).to eq("description" => "blah")
    end
  end

  describe "does not exist" do
    it "returns an empty hash" do
      expect(described_class.new(api, raw_instance_no_survey).survey_spec_hash).to be_empty
      expect(described_class.new(api, raw_instance_no_survey).survey_spec_hash).to be_a_kind_of(Hash)
    end
  end
end

shared_examples_for "JobTemplate#extra_vars_hash" do
  describe "#extra_vars exists" do
    it "returns a hashed value" do
      obj = described_class.new(instance_double("AnsibleTowerClient::Api"), raw_instance)
      expect(obj.extra_vars_hash).to eq('option' => 'lots of options')
    end
  end

  describe "#extra_vars does not exist" do
    it "returns an empty hash" do
      obj = described_class.new(instance_double("AnsibleTowerClient::Api"), raw_instance_no_extra_vars)
      expect(obj.extra_vars_hash).to be_a_kind_of(Hash)
      expect(obj.extra_vars_hash).to be_empty
    end
  end
end
