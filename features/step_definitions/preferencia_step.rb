Given(/^I am at the preferencia choice page$/) do
  visit '/preferencia/new'
end

Given(/^I have a preferencia with ordem "(.*?)"$/) do |arg1|
  Preferencia.create(ordem: arg1)
end

When(/^I submit the "(.*?)" tag$/) do |arg1|
  visit "/professor"
end

When(/^I set the selection field "(.*?)" to "(.*?)"$/) do |selection_label, aluno_name|
  select aluno_name, from: selection_label
end

When(/^I set the label "(.*?)" to "(.*?)"$/) do |selection_label, name|
  Preferencia.create(ordem: selection_label)
end
