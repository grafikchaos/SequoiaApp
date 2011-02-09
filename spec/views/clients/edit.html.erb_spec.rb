require 'spec_helper'

describe "clients/edit.html.erb" do
  before(:each) do
    @client = assign(:client, stub_model(Client))
  end

  it "renders the edit client form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => client_path(@client), :method => "post" do
    end
  end
end
