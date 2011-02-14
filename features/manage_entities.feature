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
    And entity type "Application" exists

  @entities 
  Scenario: Add an entity to an existing project
    Given I am on the client page for "ROR"
    When I follow "New Entity"
    And I fill in "Name" with "Application Login"
    And I select "Application" from "Entity type"
    And I press "Create Entity"
    Then I should be on the client page for "ROR"
    And I should see "Entity was successfully created"
    And the project "Intranet" for the client "ROR" should have 1 entity

  @entities
  Scenario: Filtering entities by project
    Given the client "ROR" has a project named "Client App" with domain "tester.com"
    And the client "ROR" has a project named "Wordpress Blog" with domain "blog.tester.com"
    And I am on the client page for "ROR"
    And the client ROR's project "Wordpress Blog" has an entity named "SSH Credentials" with type "Application"
    And the client ROR's project "Wordpress Blog" has an entity named "Admin Login" with type "Application"
    And the client ROR's project "Client App" has an entity named "User Login" with type "Application"
    When I select "All" from "project"
    And I press "Filter"
    Then I should see "SSH Credentials"
    And I should see "Admin Login"
    And I should see "User Login"
    When I select "Client App" from "project"
    And I press "Filter"
    Then I should see "User Login"
    And I should not see "SSH Credentials"
    And I should not see "Admin Login"
