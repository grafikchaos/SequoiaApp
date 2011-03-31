require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by the Rails when you ran the scaffold generator.

describe AuditsController do

  def mock_audit(stubs={})
    @mock_audit ||= mock_model(Audit, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all audits as @audits" do
      Audit.stub(:all) { [mock_audit] }
      get :index
      assigns(:audits).should eq([mock_audit])
    end
  end

  describe "GET show" do
    it "assigns the requested audit as @audit" do
      Audit.stub(:find).with("37") { mock_audit }
      get :show, :id => "37"
      assigns(:audit).should be(mock_audit)
    end
  end

  describe "GET new" do
    it "assigns a new audit as @audit" do
      Audit.stub(:new) { mock_audit }
      get :new
      assigns(:audit).should be(mock_audit)
    end
  end

  describe "GET edit" do
    it "assigns the requested audit as @audit" do
      Audit.stub(:find).with("37") { mock_audit }
      get :edit, :id => "37"
      assigns(:audit).should be(mock_audit)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "assigns a newly created audit as @audit" do
        Audit.stub(:new).with({'these' => 'params'}) { mock_audit(:save => true) }
        post :create, :audit => {'these' => 'params'}
        assigns(:audit).should be(mock_audit)
      end

      it "redirects to the created audit" do
        Audit.stub(:new) { mock_audit(:save => true) }
        post :create, :audit => {}
        response.should redirect_to(audit_url(mock_audit))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved audit as @audit" do
        Audit.stub(:new).with({'these' => 'params'}) { mock_audit(:save => false) }
        post :create, :audit => {'these' => 'params'}
        assigns(:audit).should be(mock_audit)
      end

      it "re-renders the 'new' template" do
        Audit.stub(:new) { mock_audit(:save => false) }
        post :create, :audit => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested audit" do
        Audit.stub(:find).with("37") { mock_audit }
        mock_audit.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :audit => {'these' => 'params'}
      end

      it "assigns the requested audit as @audit" do
        Audit.stub(:find) { mock_audit(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:audit).should be(mock_audit)
      end

      it "redirects to the audit" do
        Audit.stub(:find) { mock_audit(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(audit_url(mock_audit))
      end
    end

    describe "with invalid params" do
      it "assigns the audit as @audit" do
        Audit.stub(:find) { mock_audit(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:audit).should be(mock_audit)
      end

      it "re-renders the 'edit' template" do
        Audit.stub(:find) { mock_audit(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested audit" do
      Audit.stub(:find).with("37") { mock_audit }
      mock_audit.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the audits list" do
      Audit.stub(:find) { mock_audit }
      delete :destroy, :id => "1"
      response.should redirect_to(audits_url)
    end
  end

end