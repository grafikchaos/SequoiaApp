require 'spec_helper'

describe "audits/index.html.erb" do
  before(:each) do
    assign(:audits, [
      stub_model(Audit),
      stub_model(Audit)
    ])
  end

  it "renders a list of audits" do
    render
  end
end
