Given(/^I am at the aluno creation page$/) do
  visit '/alunos/new'
end

Given(/^I am an Admin named "(.*?)" with pass_hash "(.*?)"$/) do |name, pass_hash|
  User.create(name: name, pass_hash: pass_hash, position: "admin")
end

Given(/^I have an aluno with name "(.*?)" and classe "(.*?)" and sexo "(.*?)"$/) do |arg1, arg2, arg3|
  Aluno.create(name: arg1, classe: arg2, sexo: arg3)
end

When(/^I set the "(.*?)" label to "(.*?)"$/) do |arg1, arg2|
  Aluno.create(name: arg1, classe: arg2)
end

When (/^(?:|I )press "([^"]*)"$/) do |button|
  %{I press (button)}
end

When(/^I press the "(.*?)" submit_tag$/) do |arg1|
  if arg1 == "Inserir"
    visit professor_path
  end
end

When(/^I set the selection field "(.*?)" to "(.*?)"$/) do |selection_label, aluno_name|
  select aluno_name, from: selection_label
end

Then(/^I should see "(.*?)"$/) do |text|
  expect(page).to have_content(text)
end

Then (/^I should be sent to "(.*?)"$/) do |test|
  visit professor_path
end
