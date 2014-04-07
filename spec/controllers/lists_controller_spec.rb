require 'spec_helper'

describe ListsController do
  describe "GET new" do
    it "sets the @list instance variable" do
      set_current_user
      get :new
      expect(assigns(:list)).to be_new_record
      expect(assigns(:list)).to be_instance_of(List)
    end
  end

  describe "POST create" do
    context "with authenticated users" do

      before { set_current_user }

      context "with valid attributes" do

        before do
          post :create, list: Fabricate.attributes_for(:list)
        end

        it "redirects to shopping_lists show page" do
          expect(response).to redirect_to new_list_path
        end
        it "it creates a new shopping list" do
          expect(List.count).to eq(1)
        end
        it "associates the signed in user to the shopping list" do
          alice = current_user
          expect(List.first.user).to eq(alice)
        end
        it "sets flash success message" do
          expect(flash[:success]).to be_present
        end
      end

      context "with invalid attributes" do

        before do
          post :create, list: Fabricate.attributes_for(:list, name: nil)
        end

        it "does not create a shopping list" do
          expect(List.count).to eq(0)
        end
        it "renders new template" do
          expect(response).to render_template(:new)
        end
        it "sets @shopping_list" do
          expect(assigns(:list)).to be_present
        end
      end

    end

    context "with unauthenticated users" do
      it "redirects to sign in page" do
        post :create, list: Fabricate.attributes_for(:list)
        expect(response).to redirect_to sign_in_path
      end
    end
  end

  describe "GET show" do

    context "with authenticated users" do
      it "sets @shopping_list" do
        set_current_user
        list = Fabricate(:list)
        get :show, id: list.id
        expect(assigns(:list)).to eq(list)
      end

      it "sets @list_items" do
        set_current_user
        alice = current_user
        list = Fabricate(:list)
        list_item1 = Fabricate(:list_item, list: list, user: alice)
        list_item2 = Fabricate(:list_item, list: list, user: alice)
        get :show, id: list.id
        expect(assigns(:list_items)).to match_array([list_item1, list_item2])
      end
    end

    context "with unauthenticated users" do
      it "redirects to sign in page" do
        post :create, list: Fabricate.attributes_for(:list)
        expect(response).to redirect_to sign_in_path
      end
    end
  end

  describe "DELETE destroy" do

    it_behaves_like "requires sign in" do
      list = Fabricate(:list)
      let(:action) { delete :destroy, id: list.id }
    end

    it "sets @list" do
      set_current_user
      list = Fabricate(:list)
      delete :destroy, id: list.id
      expect(assigns(:list)).to eq(list)
    end

    it "deletes list" do
      set_current_user
      alice = current_user
      list = Fabricate(:list, user: alice)
      delete :destroy, id: list.id
      expect(List.count).to eq(0)
    end

    it "redirects to new_list page" do
      set_current_user
      list = Fabricate(:list)
      delete :destroy, id: list.id
      expect(response).to redirect_to new_list_path
    end
  end
end
