require "spec_helper"

describe AuditsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/audits" }.should route_to(:controller => "audits", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/audits/new" }.should route_to(:controller => "audits", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/audits/1" }.should route_to(:controller => "audits", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/audits/1/edit" }.should route_to(:controller => "audits", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/audits" }.should route_to(:controller => "audits", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/audits/1" }.should route_to(:controller => "audits", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/audits/1" }.should route_to(:controller => "audits", :action => "destroy", :id => "1")
    end

  end
end
