class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.where(username: params[:username]).first
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to home_path, notice: "Signed in successfully."
    else
      redirect_to sign_in_path
      flash[:danger] = "Invalid username or password."
    end
  end
end
