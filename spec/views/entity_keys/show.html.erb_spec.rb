require 'spec_helper'

describe "entity_keys/show.html.erb" do
  before(:each) do
    @entity_key = assign(:entity_key, stub_model(EntityKey))
  end

  it "renders attributes in <p>" do
    render
  end
end
