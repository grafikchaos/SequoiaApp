Feature: Manage entities
  In order to store the sensitive or hard-to-remember information about a client's project
  As a staff member
  I want to be able to manage the information for each client and project
  
  Background: Allowed Entity Types and Entity Keys
      Given the following Entity Types are allowed
        | name            |
        | api             |
        | application     |
        | computer        |
        | database        |
        | email           |
        | ftp             |
        | payment gateway |
        | remote desktop  |
        | ssh             |
        | version control |
        | vpn             |
        | website         |
        | wireless        |
      And the following Entity Keys exist
        | api key         |
        | database name   |
        | domain          |
        | email address   |
        | encryption key  |
        | endpoint url    |
        | host            |
        | password        |
        | port            |
        | protocol        |
        | token           |
        | transaction key |
        | url             |
        | username        |
        | wsdl url        |
      And I have client codes "ROR"
      And I am logged in as a user
      And the client "ROR" has a project named "Intranet" with domain "intranet.com"
  
  @entities @authenticate
  Scenario: New Entity button is present on the client's show template
    When I go to the client page for "ROR"
    Then I should see "New Entity"

  @wip @entities @authenticate
  Scenario: Default Entity form has Entity Row subform fields
    Given I am on the client page for "ROR"
    When I follow "New Entity"
    Then I should see "Entity type"
    And I should see "Name"
    And "form#new_entity" should have 3 "/entity[entity_rows_attributes][\d+][entity_key_id]"
    And "form#new_entity" should have 3 "/entity[entity_rows_attributes][\d+][value]"

  @entities 
  Scenario: Add an entity to an existing project
    Given I am on the client page for "ROR"
    When I follow "New Entity"
    And I fill in "Name" with "Application Login"
    And I select "application" from "Entity type"
    And I press "Create Entity"
    Then I should be on the client page for "ROR"
    And I should see "Entity was successfully created"
    And the project "Intranet" for the client "ROR" should have 1 entity

  @entities
  Scenario: Filtering entities by project
    Given the client "ROR" has a project named "Client App" with domain "tester.com"
    And the client "ROR" has a project named "Wordpress Blog" with domain "blog.tester.com"
    And I am on the client page for "ROR"
    And the client "ROR"'s project "Wordpress Blog" has an entity named "SSH Credentials" with type "application"
    And the client "ROR"'s project "Wordpress Blog" has an entity named "Admin Login" with type "application"
    And the client "ROR"'s project "Client App" has an entity named "User Login" with type "application"
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

  @entities
  Scenario: Deleting an entity
    Given the client "ROR" has a project named "Client App" with domain "tester.com"
    And the client "ROR" has a project named "Wordpress Blog" with domain "blog.tester.com"
    And I am on the client page for "ROR"
    And the client "ROR"'s project "Wordpress Blog" has an entity named "SSH Credentials" with type "application"
    And the client "ROR"'s project "Wordpress Blog" has an entity named "Admin Login" with type "application"
    And the client "ROR"'s project "Client App" has an entity named "User Login" with type "application"
    When I select "All" from "project"
    And I press "Filter"
    When I follow "delete-ssh-credentials" to delete requiring confirmation
    And I select "All" from "project"
    And I press "Filter"
    Then I should see "Admin Login"
    And I should see "User Login"
    And I should not see "SSH Credentials"
