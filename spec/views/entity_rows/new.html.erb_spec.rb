require 'spec_helper'

describe "entity_rows/new.html.erb" do
  before(:each) do
    assign(:entity_row, stub_model(EntityRow).as_new_record)
  end

  it "renders new entity_row form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => entity_rows_path, :method => "post" do
    end
  end
end
