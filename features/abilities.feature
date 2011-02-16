@abilities
Feature: Abilities - Roles and Permissions
  In order to restrict what resources users may create, read, update or delete
  As a fan of flexible ACLs
  I want to be able to define what each role has permission to do with a resource

  Background:
    Given the following user records
      | username               | password           | role    | clearance |
      | buttercup              | princess           | staff   | 3         |
      | valerie                | imnotawitch        | staff   | 2         |
      | theimpressiveclergyman | truwuv             | staff   | 1         |
      | humperdinck            | tothedeath         | staff   | 0         |
      | miraclemax             | toblave            | manager | 1         |
      | vizzini                | inconceivable      | manager | 2         |
      | sixfingeredman         | stopsayingthat     | manager | 3         |
      | dreadpirateroberts     | asyouwish          | admin   | 1         |
      | inigo                  | preparetodie       | admin   | 2         |
      | fezzik                 | anybodywantapeanut | admin   | 3         |

  @admin @entityTypes @create
  Scenario: Admins can see create link for Entity Types
    Given I am logged in as "dreadpirateroberts" with password "asyouwish"
    When I go to the list of Entity Types
    Then I should see "New Entity Type"

  @admin @entityTypes @create
  Scenario: Admins can see create Entity Types
    Given I am logged in as "dreadpirateroberts" with password "asyouwish"
    And I have no entity_types
    And I am on the new Entity Type page
    When I fill in "Name" with "API"
    And I press "Create Entity Type"
    Then I should see "Entity Type was successfully created."
    And I should be on the list of Entity Types
    And I should see "API"
    And I should have 1 entity_type

  @admin @entityTypes @edit
  Scenario: Admins can see edit link for Entity Types
    Given I am logged in as "dreadpirateroberts" with password "asyouwish"
    And entity type "Database" exists
    And I should have 1 entity_type
    When I go to the list of Entity Types
    Then I should see "Edit"

  @wip @entityTypes @edit
  Scenario: Admins can edit Entity Types
    
  @wip @entityTypes @delete
  Scenario: Admins can delete Entity Types

  @wip @entityKeys @create
  Scenario: Admins can create Entity Keys

  @wip @entityKeys @edit
  Scenario: Admins can edit Entity Keys

  @wip @entityKeys @delete
  Scenario: Admins can delete Entity Keys

  @wip
  Scenario: Admins can create Users

  @wip
  Scenario: Admins can edit Users
    
  @wip
  Scenario: Admins can delete Users

  @wip
  Scenario: Admins can create Entities

  @wip
  Scenario: Admins can edit Entities
    
  @wip
  Scenario: Admins can delete Entities

  @wip
  Scenario: Admins can create Clients

  @wip
  Scenario: Admins can edit Clients
    
  @wip
  Scenario: Admins can delete Clients

  @wip
  Scenario: Admins can create Projects

  @wip
  Scenario: Admins can edit Projects

  @wip
  Scenario: Admins can delete Projects
  
  @wip
  Scenario: Only Admins can create Admins
  
  
  
  
  
  
