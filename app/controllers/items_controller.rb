class ItemsController < ApplicationController

  def index
    @items = Item.all
  end

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

  def search
    @results = Item.search(params[:s], params[:e])
  end

  private

  def item_params
    params.require(:item).permit(:name, :price, :shop_id, :new_shop, :description)
  end
end
