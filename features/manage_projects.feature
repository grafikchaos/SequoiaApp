Feature: Manage projects
  In order to quickly view entities related to a client's project
  As a staff member
  I want to have entities attached to projects rather than clients

  Background: Make sure the client exists
    Given I am logged in as a user
    And I have client codes ROR
    And I am on the client page for "ROR"

  @clients @projects @staff
  Scenario: Create a valid project for a client
    Given the client "ROR" does not have a project named "Intranet"
    When I follow "New Project"
    And I fill in "Project Name" with "Intranet"
    And I fill in "Project Domain" with "intranet.ror.local"
    And I press "Create Project"
    Then I should see "Project was successfully created"
    And I should be on the client page for "ROR"
    And I should see "Intranet"
    #And I should see "intranet.ror.local"

  @clients @projects @staff
  Scenario: Adding a project with no project name
    Given the client "ROR" does not have a project named "Intranet"
    When I follow "New Project"
    And I fill in "Project Domain" with "intranet.ror.local"
    And I press "Create project"
    Then I should see "Name can't be blank"
    And I should have 1 project
    And the client "ROR" should not have a project named "Intranet"
    And the client "ROR" should have a project named "Default"

  @projects @staff
  Scenario: Editing a project
    Given the client "ROR" has a default project named "Intranet" with domain "intranet.com"
    When I follow "Manage projects"
    And I follow "Edit"
    And I fill in "Project Name" with "A Project"
    And I fill in "Project Domain" with "google.com"
    And I press "Update project"
    Then I should be on the client page for "ROR"
    And I should see "A Project"
    #And I should see "google.com"

  @projects @staff
  Scenario: Deleting a project
    Given the client "ROR" has a project named "Intranet" with domain "intranet.com"
    And the client "ROR" has 2 projects
    When I follow "Manage projects"
    And I follow "Delete"
    Then I should be on the list of projects for "ROR"
    And I should not see "Default"
    And the client "ROR" should not have a project named "Default"
    And the client "ROR" should have 1 project
