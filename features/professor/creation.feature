Feature: Professor Creation
  In order to create a professor account
  As a Professor
  I want to be able to create a my own account

  Scenario: with valid fields
    Given I am at the login page
    When I fill the "name" field with "Levi"
    And I fill the "pass" field with "judah"
    And I submit the "Enviar" tag
    Then I should see "Seleção de grupos inteligente"

  Scenario: without a name
    Given I am at the preferencia choice page
    When I submit the "Inserir" tag
    Then I should see "Seleção de grupos inteligente"
