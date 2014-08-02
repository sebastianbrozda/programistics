When(/^I add note to favorites$/) do
  click_button "app-add-note-to-favorites"
end

When(/^I visit the my favorite notes page$/) do
  visit favorite_notes_path
end

Then(/^add button should hide but remove button should appear$/) do
  step %Q{I wait 1 seconds}
  step %Q{"app-add-note-to-favorites" should be hidden}
  step %Q{"app-remove-note-from-favorites" should be visible}
end

Given /^I added note to favorites$/ do
  steps %Q{
  And I am logged in
  And I visit the home page
  When I click "ruby on rails" link
  Then I should be redirected to the note details "ruby on rails"
  When I add note to favorites}
end

Then(/^add button should appear but remove button should hide$/) do
  step %Q{I wait 2 seconds}
  step %Q{"app-add-note-to-favorites" should be visible}
  step %Q{"app-remove-note-from-favorites" should be hidden}
end
