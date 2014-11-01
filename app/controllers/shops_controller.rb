class ShopsController < ApplicationController
  def index
    @shops = Shop.order(:name).where("name like ?", "%#{params[:term]}%")
    render json: @shops.map(&:name)
  end
end
