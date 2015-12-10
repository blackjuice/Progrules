Feature: Aluno Creation
  In order to fill my list
  As an Admin
  I want to be able to create new aluno entries

  Scenario: with valid fields
    Given I am an Admin named "Judah" with pass_hash "Elohim"
    And I have an aluno with name "Gideao" and classe "C" and sexo "M"
    And I am at the aluno creation page
    When I fill the "name" field with "Gideao"
    And I set the "classe" label to "C"
    And I set the "sexo" label to "M"
    And I press "Inserir"
    Then I should be sent to "professor"
    And I should see "Seleção de grupos inteligente"

  Scenario: without a name
    Given I am at the aluno creation page
    When I submit the "Inserir" tag
    Then I should be sent to "homepage"
    Then I should see "Seleção de grupos inteligente"
