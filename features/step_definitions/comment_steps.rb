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
  table.hashes.each do |attrs|
    user = User.find_by_user_name attrs[:user_name]
    note = Note.find_by_title attrs[:note_title]

    comment = note.new_comment
    comment.comment = attrs[:comment]
    comment.user = user
    comment.save
  end
end

And(/^Comment body field should be empty$/) do
  expect(find_field('comment_body').value).to be_blank
end