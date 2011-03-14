require 'spec_helper'

describe "favorites/new.html.erb" do
  before(:each) do
    assign(:favorite, stub_model(Favorite).as_new_record)
  end

  it "renders new favorite form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => favorites_path, :method => "post" do
    end
  end
end
