And(/^I submit comment creation form with valid data for "([^"]*)" note$/) do |note_title|
  fill_in 'comment_body', with: "comment test"
  click_button "Add comment"
  sleep 2
end