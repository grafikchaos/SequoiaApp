require 'spec_helper'

describe "entity_keys/edit.html.erb" do
  before(:each) do
    @entity_key = assign(:entity_key, stub_model(EntityKey))
  end

  it "renders the edit entity_key form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => entity_keys_path(@entity_key), :method => "post" do
    end
  end
end
