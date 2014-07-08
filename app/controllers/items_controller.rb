class ItemsController < ApplicationController
  before_action :require_user
  before_action :find_item, only: [:edit, :update, :destroy]

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

  def edit
  end

  def update
    if @item.update(item_params)
      flash[:alert] = "Item Updated."
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    flash[:alert] = "Item deleted."
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(:name, :price, :shop_id, :new_shop, :description, :quantity, :purchased_at)
  end

  def find_item
    @item = Item.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "The item you were looking for could not be found."
    redirect_to root_path
  end
end
