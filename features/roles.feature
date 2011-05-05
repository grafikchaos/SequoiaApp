@roles @jake
Feature: CRUDding user and entity roles
  In order to restrict what resources users may create, read, update or delete
  As a fan of flexible ACLs
  I want to be able to define what each role has permission to do with a resource

  Background:
    Given the following user records
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
