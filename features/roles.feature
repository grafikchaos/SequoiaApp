@roles
Feature: CRUDding user and entity roles
  In order to restrict what resources users may create, read, update or delete
  As a fan of flexible ACLs
  I want to be able to define what each role has permission to do with a resource

  Background:
    Given there are no roles to begin with
      And the following role records
        | name       | is_system |
        | owner      | true      |
        | admin      | true      |
        | staff      | true      |
        | financial  | true      |
        | contractor | true      |
      And the following user records
        | username               | password           | roles                 |
        | buttercup              | princess           | owner                 |
        | valerie                | imnotawitch        | staff                 |
        | theimpressiveclergyman | truwuv             | staff                 |
        | humperdinck            | tothedeath         | staff                 |
        | miraclemax             | toblave            | contractor            |
        | vizzini                | inconceivable      | staff, financial      |
        | sixfingeredman         | stopsayingthat     | contractor, financial |
        | dreadpirateroberts     | asyouwish          | admin, staff          |
        | inigo                  | preparetodie       | admin, staff          |
        | fezzik                 | anybodywantapeanut | admin, staff          |


  @owner
  Scenario: Admins cannot assign the "owner" role to other users
    Given I am logged in as "inigo" with password "preparetodie"
      And I am on the list of Users
    When I follow "edit-humperdinck"
    Then I should see "Editing humperdinck"
      And I should not see "Owner"

  @owner
  Scenario: Owners can assign the "Owner" role
    Given I am logged in as "buttercup" with password "princess"
      And I am on the list of Users
    When I follow "edit-valerie"
    Then I should see "Editing valerie"
      And I should see "Owner"
    When I check "Owner"
      And I press "Update User"
    Then I should be on the list of Users
      And "valerie" should have the "Owner" role
      
  @admin @create
  Scenario: Admins can create new roles
    Given I am logged in as "inigo" with password "preparetodie"
      And I am on the list of roles
    When I follow "New Role"
      And I fill in "Name" with "sales"
      And I press "Create Role"
    Then I should be on the list of roles
      And I should see "sales"
      And I should see "Role was successfully created"

  @admin @cancel
  Scenario: Pressing cancel while creating a Role will take you back to the list of Roles
    Given I am logged in as "inigo" with password "preparetodie"
      And I am on the list of roles
    When I follow "New Role"
      And I fill in "Name" with "sales"
      And I follow "Cancel"
    Then I should be on the list of roles
      And I should not see "sales"
  
  @admin
  Scenario: Admins can edit roles that aren't system roles
    Given the following role records
      | name  | is_system |
      | sales | false     |
      And I am logged in as "inigo" with password "preparetodie"
      And I am on the list of roles
    When I follow "edit-sales"
      And I fill in "Name" with "customer service"
      And I press "Update Role"
    Then I should be on the list of Roles
      And I should not see "sales"
      And I should see "customer service"
      And I should see "Role was successfully updated"
  
  @system_roles @admin
  Scenario: Admins can't edit roles that are  system roles
    Given I am logged in as "inigo" with password "preparetodie"
      And I am on the list of roles
    Then I should not see "edit-owner"
      And I should not see "edit-admin"
      And I should not see "edit-staff"
      And I should not see "edit-financial"
      And I should not see "edit-contractor"

  @system_roles
  Scenario: Not even owners can edit/delete system roles
    Given I am logged in as "buttercup" with password "princess"
      And the following role records
        | name    | is_system |
        | Tester  | true      |
        | Biker   | true      |
        | Driver  | false     |
    When I go to the edit role page for "Tester" 
    Then I should see "Access Denied"
    When I go to the edit role page for "Biker" 
    Then I should see "Access Denied"
    When I go to the edit role page for "Driver" 
    Then I should see "Edit Role"

