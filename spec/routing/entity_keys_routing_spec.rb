require "spec_helper"

describe EntityKeysController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/entity_keys" }.should route_to(:controller => "entity_keys", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/entity_keys/new" }.should route_to(:controller => "entity_keys", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/entity_keys/1" }.should route_to(:controller => "entity_keys", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/entity_keys/1/edit" }.should route_to(:controller => "entity_keys", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/entity_keys" }.should route_to(:controller => "entity_keys", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/entity_keys/1" }.should route_to(:controller => "entity_keys", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/entity_keys/1" }.should route_to(:controller => "entity_keys", :action => "destroy", :id => "1")
    end

  end
end
