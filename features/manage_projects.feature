Feature: Manage projects
  In order to quickly view entities related to a client's project
  As a staff member
  I want to have entities attached to projects rather than clients
  
  @clients @projects @staff
  Scenario: Create a valid project for a client
    Given client "ROR" exists
    And I am on the client page for "ROR"
    And the client "ROR" does not have a project named "Intranet"
    When I follow "New Project"
    And I fill in "Project Name" with "Intranet"
    And I fill in "Project Domain" with "intranet.ror.local"
    And I press "Create Project"
    # Then I should see "New Project created"
    Then I should be on "ROR"'s "Intranet" project page
    And I should see "Intranet" 
  
  

  
