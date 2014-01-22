class ItemsController < ApplicationController
  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:success] = "Item successfully added."
      redirect_to new_item_path
    else
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :price, :shop_id)
  end
end
