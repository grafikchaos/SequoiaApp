@notable
Feature: Notable
  In order to document miscellaneous meta data
  As a staff member
  I want to be able to create notes for a Client, Project, or Entity
  
  Background: Make sure I'm logged in and a Client has a Project with one or more entities
    Given I am logged in as a user
    And I have client codes ROR
    And the following entity_type records
      | name            |
      | VPN             |

  @clients
  Scenario: Client form should have a Note text area
    Given I am on the home page
    When I follow "New Client"
    Then I should see "Note"
  
  @clients
  Scenario: Add a note to a Client
    Given I am on the new client page
    When I fill in "Name" with "Apple"
    And I fill in "Client code" with "APPL"
    And I fill in "Project Name" with "OS X LIGER"
    And I fill in "Note" with "It's pretty much my favorite animal. It's like a lion and a tiger mixed... bred for its skills in magic."
    And I press "Create Client"
    Then I should be on the client page for "APPL"
    And I should see "Client was successfully created"
    And I should see "APPL"
    And I should see "OS X LIGER" within "#project"
    And I should see "It's pretty much my favorite animal. It's like a lion and a tiger mixed... bred for its skills in magic." within "#notes"


  @projects
  Scenario: Project form should have a Note text area
    Given I am on the client page for "ROR"
    When I follow "New Project"
    Then I should see "Note"
  
  @projects
  Scenario: Add a note to a Project
    Given I have client codes "APPL"
    And I am on "APPL"'s new project page
    When I fill in "Project Name" with "Sabertooth"
    And I fill in "Note" with "Filepath is /var/www/path/to/application"
    And I press "Create Project"
    Then I should see "Project was successfully created"
    And I should be on the client page for "APPL"
    And I should see "Sabertooth" within "#project"
    And I should see "Filepath is /var/www/path/to/application" within "#project-notes"

  @entities
  Scenario: Entity form should have a Note text area
    Given I have client codes "APPL"
    And I am on the client page for "APPL"
    When I follow "New Entity"
    Then I should see "Note"
  

  @entities
  Scenario: Add a note to an Entity
    Given I have client codes "APPL"
    And the client "APPL" has a project named "Liger" with domain "liger.apple.com"
    And I am on the client page for "APPL"
    When I follow "New Entity"
    And I fill in "Name" with "VPN Login"
    And I select "VPN" from "Entity type"
    And I fill in "Note" with "Must use Safari for VPN client connection"
    And I press "Create Entity"
    Then I should be on the client page for "APPL"
    And I should see "Entity was successfully created"
    And the project "Liger" for the client "APPL" should have 1 entity
