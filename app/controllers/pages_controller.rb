class PagesController < ApplicationController
  def front
    redirect_to sign_in_path if current_user
  end
end
