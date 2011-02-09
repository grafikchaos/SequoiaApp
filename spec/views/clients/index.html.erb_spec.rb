require 'spec_helper'

describe "clients/index.html.erb" do
  before(:each) do
    assign(:clients, [
      stub_model(Client),
      stub_model(Client)
    ])
  end

  it "renders a list of clients" do
    render
  end
end
