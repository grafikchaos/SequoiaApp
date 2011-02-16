Feature: Manage entity_rows
  In order to be able to add things to Entities 
  A user
  wants [behaviour]
  
  Background: Entity Keys exist, etc.
    Given the following Entity Types exist
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
      | name            |
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
    And I am logged in as a user with Level 2 clearance
    And the client "ROR" has a project named "Intranet" with domain "intranet.com"

  @entity_rows
  Scenario: Add new entity rows when adding a new entity
    Given I am on the client page for "ROR"
    When I follow "New Entity"
    And I fill in "Name" with "Server"
    And I select "password" from "entity[entity_rows_attributes][0][entity_key_id]"
    And I fill in "entity[entity_rows_attributes][0][value]" with "iamcool"
    And I press "Create Entity"
    Then I should be on the client page for "ROR"
    And I should see "Server"
    And I should see "password:"
    And I should see "iamcool"

  @entity_rows
  Scenario: Edit entity rows within an existing entity
    Given the following Entities exist
      | client    |  project        | name            | type        | level   |
      | ROR       |  Intranet       | Admin Login     | application | 3       |
    And the following Entity Rows exist
      | client    |  project        | entity          | key         | value   |
      | ROR       |  Intranet       | Admin Login     | password    | 12345   |
    And I am on the client page for "ROR"
    When I follow "edit-admin-login"
    And I fill in "entity[entity_rows_attributes][0][value]" with "67890"
    And I press "Update Entity"
    Then I should be on the client page for "ROR"
    And I should see "password:"
    And I should see "67890"
    And I should not see "12345"