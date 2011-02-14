require 'spec_helper'

describe "entity_rows/edit.html.erb" do
  before(:each) do
    @entity_row = assign(:entity_row, stub_model(EntityRow))
  end

  it "renders the edit entity_row form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => entity_rows_path(@entity_row), :method => "post" do
    end
  end
end
