Given(/^I visit the note creation form$/) do
  visit new_note_path
end

When(/^I submit note creation form with valid data$/) do
  fill_note_creation_form({note_type: "public"})
  click_button 'Create Note'
end

Then(/^I should be redirected to the newly created note$/) do
  expect(current_path).to eq(note_path(Note.last))
end

When(/^I submit note creation form with invalid data$/) do
  fill_in :note_title, with: ""
  fill_in :note_body, with: "Note body"
  select('public', :from => :note_note_type_id)
  step %Q{I submit note form creation}
end

And(/^I submit note form creation$/) do
  click_button 'Create Note'
end

And(/^there are notes:$/) do |table|
  table.hashes.each do |attrs|
    user = User.find_by_user_name attrs[:user_name]
    user = FactoryGirl.create(:user, user_name: attrs[:user_name]) unless user
    attrs[:user] = user

    tags = attrs[:tags]

    ["user_name", "tags"].each { |k| attrs.delete k }

    note = Note.new attrs.except(:user_name)
    note.tag_list = tags
    note.save
  end
end

Then(/^I should be redirected to the note details "(.+)"$/) do |title|
  note = Note.find_by_title title
  expect(current_url).to include(note.to_param)
end

When(/^I visit the my notes page$/) do
  visit my_own_notes_path
end

Then(/^I should see only my notes$/) do
  steps %Q{
  And I should see "title 1-1 public"
  And I should see "title 1-2 private"
  And I should not see "title 2"
  And I should not see "title 3"
  }
end

Given(/^I fill creation form to create paid access note$/) do
  fill_note_creation_form({note_type: "paid access"})
  step %Q{I wait 1 seconds}
  step %Q{I should see "Price for access"}
  fill_in :note_price_for_access, with: 100
end

Then(/^I should see "([^"]*)" and note body$/) do |type_name|
  step %Q{I should see "#{type_name}"}
  step %Q{I should see "Note body"}
end

And(/^I have paid access to note "([^"]*)"$/) do |note_title|
  current_user.purchased << Note.find_by_title(note_title)
  current_user.save
end

Given(/^I visit the "([^"]*)" note page$/) do |title|
  note = Note.find_by_title title
  visit note_path(note)
end
