require 'spec_helper'

describe "favorites/index.html.erb" do
  before(:each) do
    assign(:favorites, [
      stub_model(Favorite),
      stub_model(Favorite)
    ])
  end

  it "renders a list of favorites" do
    render
  end
end
