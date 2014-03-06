def set_current_user
  bob = Fabricate(:user)
  session[:user_id] = bob.id
end
