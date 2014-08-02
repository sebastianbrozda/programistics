Given(/^I am not logged in$/) do
  page.driver.browser.execute_script %Q{
    $("#menu-profile").trigger("mouseenter").click();
  }
  click_link "Log out"
end

And(/^I log out$/) do
  step %Q{I am not logged in}
end

Given(/^I visit the user registration page$/) do
  visit new_user_registration_path
end

When(/^I fill in user details with valid data$/) do
  fill_in "user_email", with: "validemail@example.com"
  fill_in "user_password", with: "secret123"
  fill_in "user_user_name", with: "user_name1"
  fill_in "user_password_confirmation", with: "secret123"
end

Then(/^I should be redirected to the home page$/) do
  current_path.should eq(root_path)
end

Given(/^I am logged in$/) do
  sign_in
end

When(/^I log in$/) do
  step %Q{I am logged in}
end

Then(/^I should be redirected to the log in page$/) do
  current_path.should eq(new_user_session_path)
end

When(/^I visit the home page$/) do
  visit root_path
end

And(/^I visit the profile settings page$/) do
  visit user_settings_path
end

When(/^I try to change my email$/) do
  fill_in :email, with: "user_new_email@example.com"
  click_button 'Change email'
end

Then(/^my email changes$/) do
  sleep 1
  expect(current_user.email).to eq "user_new_email@example.com"
end

When(/^I change my bitcoin wallet$/) do
  fill_in :bitcoin_wallet, with: "1N8EviejJ25T5FbiVb6CsAgPxQNAyYMob3"
  click_button "Change bitcoin wallet"
end

Then(/^my bitcoin wallet changes$/) do
  sleep 1
  expect(current_user.bitcoin_wallet).to eq "1N8EviejJ25T5FbiVb6CsAgPxQNAyYMob3"
end

When(/^I upload my new avatar$/) do
  attach_file "user_avatar", Rails.root.join('features/upload_files/BC_Logo_.png')
  click_button "Upload avatar"
end

Then(/^my avatar changes$/) do
  expect(current_user.avatar).not_to be_nil
end