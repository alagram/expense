class ShoppingListsController < ApplicationController
  def new
    @shopping_list = ShoppingList.new
  end

  def create
  end
end
