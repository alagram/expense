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
    if (both_params_blank?) || (end_param_blank?) || (start_param_blank?)
      flash.now[:error] = "Your input is incorrect."
      render :find
    else
      params_valid?
    end
  end

  private

  def both_params_blank?
    params[:s].blank? && params[:e].blank?
  end

  def end_param_blank?
    params[:e].blank?
  end

  def start_param_blank?
    params[:s].blank?
  end

  def params_valid?
    begin
      s = Date.parse(params[:s])
      e = Date.parse(params[:e])
      @results = Item.includes(:shop).search(s, e)
    rescue ArgumentError
      flash[:danger] = "Invalid date."
      redirect_to find_path
    end
  end

  def item_params
    params.require(:item).permit(:name, :price, :shop_id, :new_shop, :description)
  end
end
