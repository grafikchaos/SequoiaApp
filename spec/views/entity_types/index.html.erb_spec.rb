require 'spec_helper'

describe "entity_types/index.html.erb" do
  before(:each) do
    assign(:entity_types, [
      stub_model(EntityType),
      stub_model(EntityType)
    ])
  end

  it "renders a list of entity_types" do
    render
  end
end
