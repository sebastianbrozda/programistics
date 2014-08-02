Then(/^I should see "(.*?)"$/) do |text|
  expect(page.body.include?(text)).to eq(true)
end

When(/^I click "(.*?)" button$/) do |element|
  click_button element
end

And(/^I should not see "([^"]*)"$/) do |text|
  expect(page.body.include?(text)).to eq(false)
end

When(/^I click "([^"]*)" link$/) do |element|
  click_link element
end

And(/^Save and open page$/) do
  save_and_open_page
end

Then(/^"(.*?)" should be visible$/) do |element|
  expect(page.all("##{element}", :visible => true)).not_to be_empty
end

Then(/^"(.*?)" should be hidden$/) do |element|
  expect(page.all("##{element}", :visible => false)).not_to be_empty
end

When /^I wait (\d+) seconds?$/ do |seconds|
  sleep seconds.to_i
end