require 'spec_helper'

describe UsersController do
  describe "GET new" do
    it "sets @user instance variable" do
      get :new
      expect(assigns(:user)).to be_new_record
      expect(assigns(:user)).to be_instance_of(User)
    end
  end
end
