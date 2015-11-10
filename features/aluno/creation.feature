Feature: Aluno Creation
  In order to fill my list
  As an Admin
  I want to be able to create new aluno entries

  Scenario: with valid fields
    Given I have an aluno with name "Gideao" and classe "C" and sexo "M"
    And I am at the aluno creation page
    When I fill the "name" field with "Gideao"
    And I fill the "classe" label with "C"
    And I fill the "sexo" label with "M"
    And I submit the "Inserir" tag
    Then I should see "Gideao"
    And I should see "AABBCC"
    And I should see "C"
    And I should see "M"

  Scenario: without a name
    Given I am at the aluno creation page
    When I submit the "Inserir" tag
    Then I should see "Name can't be blank"
