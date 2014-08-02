And(/^I have access to the "([^"]*)"$/) do |title|
  current_user.purchased << Note.find_by_title(title)
  current_user.save
end

And(/^I visit the "([^"]*)" purchase page$/) do |title|
  note = Note.find_by_title title
  visit purchase_note_path note
end

Then(/^I should see coinbase iframe/) do
  page.has_css?('iframe')
end