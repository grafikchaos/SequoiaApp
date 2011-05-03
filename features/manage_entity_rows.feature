@entity_rows
Feature: Manage entity_rows
  In order to be able to add things to Entities 
  As a staff member
  I want to be able to add more information that defines an Entity
  
  Background: Entity Keys exist, etc.
    Given the following user records
      | username               | password           | roles                 |
      | buttercup              | princess           | staff                 |
      | valerie                | imnotawitch        | staff                 |
      | theimpressiveclergyman | truwuv             | staff                 |
      | humperdinck            | tothedeath         | staff                 |
      | miraclemax             | toblave            | contractor            |
      | vizzini                | inconceivable      | staff, financial      |
      | sixfingeredman         | stopsayingthat     | contractor, financial |
      | dreadpirateroberts     | asyouwish          | admin, staff          |
      | inigo                  | preparetodie       | admin, staff          |
      | fezzik                 | anybodywantapeanut | admin, staff          |
    And the following entity_type records
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
    And I am logged in as "dreadpirateroberts" with password "asyouwish"
    And I have client codes "ROR"
    And the client "ROR" has a project named "Intranet" with domain "intranet.com"
    And the following Entities exist
      | client    |  project        | name            | type        | roles |
      | ROR       |  Intranet       | Admin Login     | application | staff |
    And the following Entity Rows exist
      | client    |  project        | entity          | key         | value   |
      | ROR       |  Intranet       | Admin Login     | password    | 12345   |
      | ROR       |  Intranet       | Admin Login     | username    | fezzik  |


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
    And I am on the client page for "ROR"
    When I follow "edit-admin-login"
    And I fill in "entity[entity_rows_attributes][0][value]" with "67890"
    And I press "Update Entity"
    Then I should be on the list of entities for "ROR"
    And I should see "password:"
    And I should see "67890"
    And I should not see "12345"

 
  @javascript
  Scenario: Delete entity rows from an entity
    And I am on the client page for "ROR"
    When I follow "edit-admin-login"
    And I delete the 1st Entity Row
    And I press "Update Entity"
    Then I should be on the list of entities for "ROR"
    And I should not see "password:"
    And I should not see "12345"
    And I should see "username:"
    And I should see "fezzik"

  @javascript  
  Scenario: Undo delete entity rows from an entity
    And I am on the client page for "ROR"
    When I follow "edit-admin-login"
    And I delete the 1st Entity Row
    And I undelete the 1st Entity Row
    And I press "Update Entity"
    Then I should be on the list of entities for "ROR"
    And I should see "password:"
    And I should see "12345"
    And I should see "username:"
    And I should see "fezzik"

  @masking
  Scenario: Mask the value for keys so marked
    When I go to the client page for "ROR"
    Then I should see "port:"
    And I should see "*****"
    And I should see "username:"
    And I should see "fezzik"
