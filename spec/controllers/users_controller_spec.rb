require 'spec_helper'

describe UsersController do
  describe "GET new" do
    it "sets @user instance variable" do
      get :new
      expect(assigns(:user)).to be_new_record
      expect(assigns(:user)).to be_instance_of(User)
    end
  end

  describe "POST create" do
    context "with valid attributes" do
      it "redirects to sign in page" do
        post :create, user: Fabricate.attributes_for(:user)
        expect(response).to redirect_to sign_in_path
      end

      it "creates a new user" do
        post :create, user: Fabricate.attributes_for(:user)
        expect(User.count).to eq(1)
      end
      it "sets flash success mesaage" do
        post :create, user: Fabricate.attributes_for(:user)
        expect(flash[:success]).to be_present
      end
    end

    context "with invalid attributes" do
      it "renders new page"
      it "sets flash danger message"
      it "sets @user instance variable"
    end
  end
end
