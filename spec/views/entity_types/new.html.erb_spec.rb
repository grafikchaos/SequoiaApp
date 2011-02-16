require 'spec_helper'

describe "entity_types/new.html.erb" do
  before(:each) do
    assign(:entity_type, stub_model(EntityType).as_new_record)
  end

  it "renders new entity_type form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => entity_types_path, :method => "post" do
    end
  end
end
