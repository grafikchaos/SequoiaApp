require 'spec_helper'

describe "favorites/edit.html.erb" do
  before(:each) do
    @favorite = assign(:favorite, stub_model(Favorite))
  end

  it "renders the edit favorite form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => favorites_path(@favorite), :method => "post" do
    end
  end
end
