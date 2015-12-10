Feature: Choosing Preferencia
  In order to fill all the preferences
  As an Admin or as an aluno
  I want to be able to choose the preferences of an aluno

  Scenario: with valid fields
    Given I have a preferencia with ordem "1"
    And I am at the preferencia choice page
    When I set the label "Escolha 1" to "Mardoqueu"
    And I submit the "Inserir" tag
    Then I should see "Seleção de grupos inteligente"

  Scenario: without a name
    Given I am at the preferencia choice page
    When I submit the "Inserir" tag
    Then I should see "Seleção de grupos inteligente"
