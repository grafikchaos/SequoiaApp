@entity_type_config
Feature: Entities should have a configurable form
  To make adding entities easier and to increase data integrity and consistency
  As a staff member
  I was to be able to define a set of rows that should appear per entity type
  
  Background: Make sure I'm logged in
    Given I have client codes AA, AAA, AAI, ROR
    And the client "ROR" has a default project named "Intranet" with domain "intranet.com" 
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
    And the following Entities exist
      | client | project  | name              | type            | roles |
      | AAI    | Default  | external svn user | version control | staff |
      | ROR    | Intranet | SSH Credentials   | ssh             | staff | 
      | ROR    | Intranet | Admin Login       | application     | staff |
      | ROR    | Intranet | User Login        | application     | staff |
    And the following user records
      | username           | password  | roles        |
      | dreadpirateroberts | asyouwish | admin, staff |
    And I am logged in as "dreadpirateroberts" with password "asyouwish"
    And I am on the home page
    
  @admin @entity_types
  Scenario: Admins can add a configuration to an entity type
    Given I am on the list of Entity Types
    When I follow "New Entity Type"
      And I fill in "Name" with "Test Type"
      And I select "protocol" from "entity_type[form_configs_attributes][0][entity_key_id]"
      And I select "wsdl url" from "entity_type[form_configs_attributes][1][entity_key_id]"
      And I select "token" from "entity_type[form_configs_attributes][2][entity_key_id]"
      And I press "Create Entity Type"
      And I should see "Entity Type was successfully created"
      And I go to "ROR"'s new Entity page for entity type "Test Type"
    Then I should see "protocol" within "#entity_rows_form"
      And I should see "wsdl url" within "#entity_rows_form"
      And I should see "token" within "#entity_rows_form"
      And I should not see "transaction key" within "#entity_rows_form"
