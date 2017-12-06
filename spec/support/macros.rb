def set_current_user(user=Fabricate(:user))
  session[:user_id] = user.id
end

def sign_in_user(user=Fabricate(:user))
  visit log_in_path
  fill_in "email", with: user.email
  fill_in "password", with: user.password
  click_button "Log In"
end