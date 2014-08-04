And(/^I submit comment creation form with valid data for note$/) do
  fill_in 'comment_body', with: "comment test"
  click_button "Add comment"
  sleep 2
end

And(/^I should see added comment$/) do
  sleep 1
  step %q{I should see "comment test"}
end

And(/^there are comments:$/) do |table|
end