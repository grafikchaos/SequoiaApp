@entity_rows
Feature: Manage entity_rows
  In order to be able to add things to Entities 
  A user
  wants [behaviour]
  
  Background: Entity Keys exist, etc.
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
    And the following entity_key records
      | name            | mask  |
      | api key         | false |
      | database name   | false |
      | domain          | false |
      | email address   | false |
      | encryption key  | false |
      | endpoint url    | false |
      | host            | false |
      | password        | false |
      | port            | true  |
      | protocol        | true  |
      | token           | false |
      | transaction key | false |
      | url             | false |
      | username        | false |
      | wsdl url        | false |
    And I have client codes "ROR"
    And I am logged in as a user with Level 2 clearance
    And the client "ROR" has a project named "Intranet" with domain "intranet.com"


  Scenario: Add new entity rows when adding a new entity
    Given I am on the client page for "ROR"
    When I follow "New Entity"
    And I fill in "Name" with "Server"
    And I select "password" from "entity[entity_rows_attributes][0][entity_key_id]"
    And I fill in "entity[entity_rows_attributes][0][value]" with "iamcool"
    And I press "Create Entity"
    Then I should be on the list of entities for "ROR"
    And I should see "Server"
    And I should see "password:"
    And I should see "iamcool"


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
    Then I should be on the list of entities for "ROR"
    And I should see "password:"
    And I should see "67890"
    And I should not see "12345"

 
  @focus @javascript
  Scenario: Delete entity rows from an entity
    Given the following Entities exist
      | client    |  project        | name            | type        | level   |
      | ROR       |  Intranet       | Admin Login     | application | 3       |
    And the following Entity Rows exist
      | client    |  project        | entity          | key         | value   |
      | ROR       |  Intranet       | Admin Login     | password    | 12345   |
      | ROR       |  Intranet       | Admin Login     | username    | fezzik  |
    And I am on the client page for "ROR"
    When I follow "edit-admin-login"
    And I delete the 1st Entity Row
    And I press "Update Entity"
    Then I should be on the list of entities for "ROR"
    And I should not see "password:"
    And I should not see "12345"
    And I should see "username:"
    And I should see "fezzik"

  
  Scenario: Undo delete entity rows from an entity
    Given the following Entities exist
      | client    |  project        | name            | type        | level   |
      | ROR       |  Intranet       | Admin Login     | application | 3       |
    And the following Entity Rows exist
      | client    |  project        | entity          | key         | value   |
      | ROR       |  Intranet       | Admin Login     | password    | 12345   |
      | ROR       |  Intranet       | Admin Login     | username    | fezzik  |
    And I am on the client page for "ROR"
    When I follow "edit-admin-login"
    And I delete the 1st Entity Row
    And I undelete the Entity Row "entity_entity_rows_attributes_0__destroy"
    And I press "Update Entity"
    Then I should be on the list of entities for "ROR"
    And I should see "password:"
    And I should see "12345"
    And I should see "username:"
    And I should see "fezzik"

  @masking
  Scenario: Mask the value for keys so marked
    Given the following Entities exist
      | client    |  project        | name            | type        | level   |
      | ROR       |  Intranet       | Admin Login     | application | 3       |
    And the following Entity Rows exist
      | client    |  project        | entity          | key         | value   |
      | ROR       |  Intranet       | Admin Login     | port        | 12345   |
      | ROR       |  Intranet       | Admin Login     | username    | fezzik  |
    When I go to the client page for "ROR"
    Then I should see "port:"
    And I should see "*****"
    And I should see "username:"
    And I should see "fezzik"
