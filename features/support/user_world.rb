module UserWorld
  DefaultUserName = 'user_name1'

  def sign_in
    user = User.find_by_user_name DefaultUserName
    user = FactoryGirl.create(:user, password: "mysweetsecret123", user_name: DefaultUserName) unless user
    visit new_user_session_path
    fill_in "user_email", with: user.email
    fill_in "user_password", with: "mysweetsecret123"
    click_button "Sign in"
  end

  def current_user
    current_user ||= User.find_by_user_name DefaultUserName
  end
end

World(UserWorld)