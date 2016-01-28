require 'spec_helper'

describe AnsibleTowerClient::ResourceNotFound do
  it "#issue_error" do
    err_class = AnsibleTowerClient::ResourceNotFound.new("blah")
    err_class_with_hash = AnsibleTowerClient::ResourceNotFound.new("blah", :id => 1)
    expect(err_class.issue_error).to eq "Couldn't find blah"
    expect(err_class_with_hash.issue_error).to eq "Couldn't find blah with 'id'=1"
  end
end
