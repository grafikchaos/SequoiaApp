require 'spec_helper'

describe "entity_keys/index.html.erb" do
  before(:each) do
    assign(:entity_keys, [
      stub_model(EntityKey),
      stub_model(EntityKey)
    ])
  end

  it "renders a list of entity_keys" do
    render
  end
end
