And(/^I visit the my earnings page$/) do
  visit my_earnings_path
end

Given(/^I should see lists of my earnings$/) do
  steps %Q{
    And I should see "note4"
    And I should see "note3"
    And I should not see "note2"
    And I should not see "note1"
  }
end

Given(/^there are payments:$/) do |table|
  table.hashes.each do |attrs|
    note = FactoryGirl.create(:note, title: attrs[:note], user: current_user)
    FactoryGirl.create(:payment,
                       user_id: current_user.id,
                       note_id: note.id,
                       status: attrs[:status],
                       price: attrs[:price],
                       transaction_hash: attrs[:transaction_hash])
  end
end

And(/^the summary earning$/) do
  step %Q{I should see "300"}
end