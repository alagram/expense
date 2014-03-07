require 'spec_helper'

describe UsersController do
  describe "GET new" do
    it "sets @user instance variable" do
      get :new
      expect(assigns(:user)).to be_new_record
      expect(assigns(:user)).to be_instance_of(User)
    end
    it "redirects to home page for authenticated users" do
      set_current_user
      get :new
      expect(response).to redirect_to home_path
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

      it "does not create a user" do
        post :create, user: Fabricate.attributes_for(:user, username: nil)
        expect(User.count).to eq(0)
      end

      it "renders new page" do
        post :create, user: Fabricate.attributes_for(:user, username: nil)
        expect(response).to render_template :new
      end

      it "sets @user instance variable" do
        post :create, user: Fabricate.attributes_for(:user, username: nil)
        expect(assigns(:user)).to be_instance_of(User)
      end

    end
  end
end
