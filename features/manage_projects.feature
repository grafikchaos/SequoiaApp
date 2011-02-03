Feature: Manage projects
  In order to quickly view entities related to a client's project
  As a staff member
  I want to have entities attached to projects rather than clients
  
  @wip @clients @projects @staff
  Scenario: Create a valid project for a client
    Given client "ROR" exists
    And I am on the client page for "ROR"
    And the client does not have a project named "Intranet"
    When I follow "New Project"
    And I fill in "Name" with "Intranet"
    And I fill in "Domain" with "intranet.ror.local"
    And I press "Create Project"
    Then I should see "New Project created"
    And I should be on "Intranet Project Page"
    And I should see "Intranet"
  
  
  

  
