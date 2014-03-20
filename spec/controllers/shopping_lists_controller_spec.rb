require 'spec_helper'

describe ShoppingListsController do
  describe "GET new" do
    it "sets the @shopping_list instance variable" do
      get :new
      expect(assigns(:shopping_list)).to be_new_record
      expect(assigns(:shopping_list)).to be_instance_of(ShoppingList)
    end
  end
end
