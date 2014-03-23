class ListItemsController < ApplicationController

  def create
    list = List.find(params[:list_id])

    list_item = list.list_items.build(list_item_params.merge!(user: current_user))

    if list_item.save
      flash[:success] = "List Item added!"
      redirect_to list_list_items_path
    else
      list_item = list.list_items.reload
      render 'list_items/show'
    end
  end


  private

  def list_item_params
    params.require(:list_item).permit(:name)
  end
end
