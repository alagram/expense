def set_current_user
  bob = Fabricate(:user)
  session[:user_id] = bob.id
end

def current_user
  User.find(session[:user_id])
end

def sign_in(a_user=nil)
  user = a_user || Fabricate(:user)
  visit sign_in_path
  fill_in "username", with: user.username
  fill_in "password", with: user.password
  click_button "Sign In"
end
