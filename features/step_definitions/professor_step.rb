Given(/^I am at the login page$/) do
  visit root_path
end

When(/^I fill the "(.*?)" field with "(.*?)""$/) do |arg1|
  if arg1 == "Levi"
    User.create(name: arg1, position: "admin")
  end
  if arg1 == "judah"
    User.create(pass_hash: arg1, position: "admin")
  end
end
