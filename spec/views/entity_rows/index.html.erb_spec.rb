require 'spec_helper'

describe "entity_rows/index.html.erb" do
  before(:each) do
    assign(:entity_rows, [
      stub_model(EntityRow),
      stub_model(EntityRow)
    ])
  end

  it "renders a list of entity_rows" do
    render
  end
end
