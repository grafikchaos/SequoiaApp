require 'spec_helper'

describe "entity_types/show.html.erb" do
  before(:each) do
    @entity_type = assign(:entity_type, stub_model(EntityType))
  end

  it "renders attributes in <p>" do
    render
  end
end
