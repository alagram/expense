class ShoppingListsController < ApplicationController

  before_action :require_user

  def new
    @shopping_list = ShoppingList.new
  end

  def create
    @shopping_list = ShoppingList.new(shopping_list_params.merge(user: current_user))

    if @shopping_list.save
      redirect_to new_shopping_list_path
      flash[:success] = "You successfully created a Shopping list."
    else
      render :new
    end
  end


  private

  def shopping_list_params
    params.require(:shopping_list).permit(:name, :description)
  end
end
