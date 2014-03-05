require 'spec_helper'

describe SessionsController do
  describe "POST create" do
    context "with valid credentials" do
      it "redirects to home page" do
        bob = Fabricate(:user)
        post :create, username: bob.username, password: bob.password
        expect(response).to redirect_to home_path
      end
      it "sets the user into the session" do
        bob = Fabricate(:user)
        post :create, username: bob.username, password: bob.password
        expect(session[:user_id]).to eq(bob.id)
      end
      it "sets flash notice message" do
        bob = Fabricate(:user)
        post :create, username: bob.username, password: bob.password
        expect(flash[:notice]).to be_present
      end
    end

    context "with invalid credentials"
  end
end
