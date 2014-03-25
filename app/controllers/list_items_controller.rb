class ListItemsController < ApplicationController

  before_action :require_user

  def create
    @list = List.find(params[:list_id])

    @list_item = @list.list_items.build(list_item_params.merge!(user: current_user))

    if @list_item.save
      flash[:success] = "List Item added!"
      redirect_to @list
    else
      @list_items = @list.list_items.reload
      render 'lists/show'
    end
  end

  def destroy
    @list = List.find(params[:list_id])
    @list_item = ListItem.find(params[:id])
    @list_item.delete if @list_item.user == current_user
    redirect_to @list
  end


  private

  def list_item_params
    params.require(:list_item).permit(:name)
  end
end