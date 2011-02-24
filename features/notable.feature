@notable
Feature: Notable
  In order to document miscellaneous meta data
  As a staff member
  I want to be able to create notes for a Client, Project, or Entity
  
  Background: Make sure I'm logged in and a Client has a Project with one or more entities
    Given I am logged in as a user
    And I have client codes ROR

  @clients
  Scenario: Client form should have a Note text area
    Given I am on the list of clients
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


  @wip @projects
  Scenario: Project form should have a Note text area
  
  @wip @projects
  Scenario: Add a note to a Project

  @wip @entities
  Scenario: Entity form should have a Note text area

  @wip @entities
  Scenario: Add a note to an Entity
