require 'spec_helper'

describe "entity_keys/new.html.erb" do
  before(:each) do
    assign(:entity_key, stub_model(EntityKey).as_new_record)
  end

  it "renders new entity_key form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => entity_keys_path, :method => "post" do
    end
  end
end
