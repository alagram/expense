class ItemsController < ApplicationController
  before_action :require_user

  def index
    @items = current_user.items.includes(:shop)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params.merge!(user: current_user))
    if @item.save
      flash[:success] = "Item successfully added."
      redirect_to new_item_path
    else
      render :new
    end
  end

  def search
    @results = Item.includes(:shop).search(Date.parse(params[:s]), Date.parse(params[:e])).where(user: current_user)
  rescue ArgumentError
    flash[:danger] = "Invalid date. Please check your input."
    redirect_to find_path
  end

  private

  def item_params
    params.require(:item).permit(:name, :price, :shop_id, :new_shop, :description, :quantity, :purchased_at)
  end
end
