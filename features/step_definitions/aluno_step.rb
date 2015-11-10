Given(/^I am at the aluno creation page$/) do
  #visit new_aluno_path
  visit root_path
end

#Given(/^I have a Aluno with name "(.*?)" and rand_pass "(.*?)" and classe "(.*?)" and sexo "(.*?)"$/) do |name, rand_pass, classe, sexo|
#  Aluno.create(name: name, rand_pass: rand_pass, classe: classe, sexo: sexo)
#end

Given(/^I have an aluno with name "(.*?)" and classe "(.*?)" and sexo "(.*?)"$/) do |arg1, arg2, arg3|
  Aluno.create(name: arg1, classe: arg2, sexo: arg3)
end

When(/^I fill the "(.*?)" label with "(.*?)"$/) do |arg1, arg2|
  Aluno.create(name: arg1, classe: arg2)
end

When(/^I submit the "(.*?)" tag$/) do |arg1|
  visit "/professor"
end

When(/^I set the selection field "(.*?)" to "(.*?)"$/) do |selection_label, aluno_name|
  select aluno_name, from: selection_label
end
