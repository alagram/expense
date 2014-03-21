class ListsController < ApplicationController

  before_action :require_user

  def new
    @list = List.new
    @lists = current_user.lists
  end

  def create
    @list = List.new(list_params.merge(user: current_user))

    if @list.save
      flash[:success] = "You successfully created a Shopping list."
      redirect_to new_list_path
    else
      @lists = current_user.lists.reload
      render :new
    end
  end

  def show
    @shopping_list_item = ShoppingListItem.new
    @list = List.find(params[:id])
  end


  private

  def list_params
    params.require(:list).permit(:name, :description)
  end
end
