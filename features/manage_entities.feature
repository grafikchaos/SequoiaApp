Feature: Manage entities
  In order to store the sensitive or hard-to-remember information about a client's project
  As a staff member
  I want to be able to manage the information for each client and project
  
  Background: Allowed skills
      #Given the following Entity Types are allowed
      #| api             |
      #| application     |
      #| computer        |
      #| database        |
      #| email           |
      #| ftp             |
      #| payment gateway |
      #| remote desktop  |
      #| ssh             |
      #| version control |
      #| vpn             |
      #| website         |
      #| wireless        |
    Given I have client codes ROR
    And the client "ROR" has a project named "Intranet" with domain "intranet.com"
    And I am logged in as a user

  @entities 
  Scenario: Add an entity to an existing project
    Given I am on the client page for "ROR"
    And entity type "Application" exists
    When I follow "New Entity"
    And I fill in "Name" with "Application Login"
    And I select "Application" from "Entity type"
    And I press "Create Entity"
    Then I should be on the client page for "ROR"
    And I should see "Entity was successfully created"
    And the project "Intranet" for the client "ROR" should have 1 entity
