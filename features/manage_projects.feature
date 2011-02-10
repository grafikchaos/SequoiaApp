Feature: Manage projects
  In order to quickly view entities related to a client's project
  As a staff member
  I want to have entities attached to projects rather than clients

  Background: Make sure the client exists
    Given client "ROR" exists
    And I am on the client page for "ROR"

  @clients @projects @staff
  Scenario: Create a valid project for a client
    Given the client "ROR" does not have a project named "Intranet"
    When I follow "New Project"
    And I fill in "Project Name" with "Intranet"
    And I fill in "Project Domain" with "intranet.ror.local"
    And I press "Create Project"
    # Then I should see "New Project created"
    Then I should be on "ROR"'s "Intranet" project page
    And I should see "Intranet"
    # And I should see "intranet.ror.local"

  @clients @projects @staff
  Scenario: Adding a project with no project name
    Given the client "ROR" does not have a project named "Intranet"
    When I follow "New Project"
    And I fill in "Project Domain" with "intranet.ror.local"
    # Then I should see "Project Name cannot be blank"
    Then I should be on "ROR"'s new project page
    And I should have 1 project
    And the client "ROR" should not have a project named "Intranet"
    And the client "ROR" should have a project named "Default"

  @wip @projects @staff
  Scenario: Editing a project

  @wip @projects @staff
  Scenario: Deleting a project
