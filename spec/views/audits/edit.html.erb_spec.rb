require 'spec_helper'

describe "audits/edit.html.erb" do
  before(:each) do
    @audit = assign(:audit, stub_model(Audit))
  end

  it "renders the edit audit form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => audits_path(@audit), :method => "post" do
    end
  end
end
