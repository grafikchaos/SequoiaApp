require 'spec_helper'

describe "entity_types/edit.html.erb" do
  before(:each) do
    @entity_type = assign(:entity_type, stub_model(EntityType))
  end

  it "renders the edit entity_type form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => entity_types_path(@entity_type), :method => "post" do
    end
  end
end
