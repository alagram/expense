class ListsController < ApplicationController

  before_action :require_user
  before_action :find_list, only: [:show, :destroy]

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
    @list_item = ListItem.new
    @list_items = @list.list_items
  end

  def destroy
    @list.destroy if @list.user == current_user
    redirect_to new_list_path
    flash[:alert] = "List with all associated contents successfully deleted."
  end


  private

  def list_params
    params.require(:list).permit(:name, :description)
  end

  def find_list
    @list = List.find(params[:id])
  end
end
