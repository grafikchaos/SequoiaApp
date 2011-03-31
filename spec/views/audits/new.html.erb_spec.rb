require 'spec_helper'

describe "audits/new.html.erb" do
  before(:each) do
    assign(:audit, stub_model(Audit).as_new_record)
  end

  it "renders new audit form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => audits_path, :method => "post" do
    end
  end
end
