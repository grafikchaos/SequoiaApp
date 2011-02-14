require 'spec_helper'

describe "entity_rows/show.html.erb" do
  before(:each) do
    @entity_row = assign(:entity_row, stub_model(EntityRow))
  end

  it "renders attributes in <p>" do
    render
  end
end
