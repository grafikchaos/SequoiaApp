Feature: Manage entities
  In order to store the sensitive or hard-to-remember information about a client's project
  As a staff member
  I want to be able to manage the information for each client and project
  
  Background: Allowed Entity Types
      Given the following entity_type records
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
      And I have client codes "ROR"
      And I am logged in as a user with Level 2 clearance
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
    And the following Entities exist
      | client    |  project        | name            | type        | level   |
      | ROR       |  Wordpress Blog | SSH Credentials | ssh         | 2       |
      | ROR       |  Wordpress Blog | Admin Login     | application | 3       |
      | ROR       |  Client App     | User Login      | application | 3       |
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

  @entities @clearance
  Scenario: Restricting access to entities based on clearance level
    Given the following Entities exist
      | client    |  project        | name            | type        | level   |
      | ROR       |  Intranet       | SSH Credentials | ssh         | 1       |
      | ROR       |  Intranet       | Admin Login     | application | 2       |
      | ROR       |  Intranet       | User Login      | application | 3       |
    When I go to the client page for "ROR"
    Then I should see "Admin Login"
    And I should see "User Login"
    And I should not see "SSH Credentials"

  @entities @clearance
  Scenario: User can't add an entity with a higher clearance
    Given I am on the client page for "ROR"
    When I follow "New Entity"
    Then I should see "Level 3"
    And I should see "Level 2"
    And I should not see "Level 1"
    And I should not see "Level 0"

  @entities @projects @clearance
  Scenario: User can't delete project containing entities with higher clearance
    Given the following Entities exist
      | client    |  project        | name            | type        | level   |
      | ROR       |  Intranet       | SSH Credentials | ssh         | 1       |
    And I am on the client page for "ROR"
    When I follow "Manage Projects"
    Then I should only see 1 delete link

  @entities
  Scenario: Editing an entity
    Given the following Entities exist
      | client    |  project        | name            | type        | level   |
      | ROR       |  Intranet       | SSH Credentials | ssh         | 2       |
    And I am on the client page for "ROR"
    When I follow "edit-ssh-credentials"
    And I fill in "Name" with "New SSH Credentials"
    And I press "Update Entity"
    Then I should be on the client page for "ROR"
    And I should see "New SSH Credentials"

  @entities
  Scenario: Deleting an entity
    Given the client "ROR" has a project named "Client App" with domain "tester.com"
    And the client "ROR" has a project named "Wordpress Blog" with domain "blog.tester.com"
    And I am on the client page for "ROR"
    And the following Entities exist
      | client    |  project        | name            | type        | level   |
      | ROR       |  Wordpress Blog | SSH Credentials | ssh         | 2       |
      | ROR       |  Wordpress Blog | Admin Login     | application | 3       |
      | ROR       |  Client App     | User Login      | application | 3       |
    When I select "All" from "project"
    And I press "Filter"
    When I follow "delete-ssh-credentials"
    And I select "All" from "project"
    And I press "Filter"
    Then I should see "Admin Login"
    And I should see "User Login"
    And I should not see "SSH Credentials"
        
  
