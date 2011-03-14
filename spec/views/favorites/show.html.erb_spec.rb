require 'spec_helper'

describe "favorites/show.html.erb" do
  before(:each) do
    @favorite = assign(:favorite, stub_model(Favorite))
  end

  it "renders attributes in <p>" do
    render
  end
end
