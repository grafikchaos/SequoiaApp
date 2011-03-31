require 'spec_helper'

describe "audits/show.html.erb" do
  before(:each) do
    @audit = assign(:audit, stub_model(Audit))
  end

  it "renders attributes in <p>" do
    render
  end
end
