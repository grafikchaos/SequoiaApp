Feature: Manage Clients
  In order to efficiently access and store client data in our intranet
  As a staff member
  I want to create and manage clients
  
  Background: Make sure I'm logged in
    Given I am logged in as a user

  @clients @authenticate
  Scenario: Client form has project subform fields
    Given I am on the search results page
    When I follow "New Client"
    Then I should see "Name"
      And I should see "Client Code"
      And I should see "Project Name"
      And I should see "Project Domain"
  
  @clients @staff @authenticate
  Scenario: Create a valid client
    Given I have no clients
      And I am on the new client page
    When I fill in "Name" with "Ruby on Rails"
      And I fill in "Client Code" with "ROR"
      And I fill in "Project Name" with "Shallow Routing"
      And I fill in "Project Domain" with "Shallow Routing"
      And I press "Create Client"
    Then I should be on the client page for "ROR"
      And I should see "Client was successfully created"
      And I should see "ROR"
      And I should see "Shallow Routing" within "#project"
      And I should have 1 client

  @clients @staff @authenticate
  Scenario: Create a client with no custom first project
    Given I have no clients
      And I am on the new client page
    When I fill in "Name" with "Ruby on Rails"
      And I fill in "Client Code" with "ROR"
      And I press "Create Client"
    Then I should be on the client page for "ROR"
      And I should see "Client was successfully created"
      And I should see "ROR"
      And I should see "Default" within "#project"
      And I should have 1 client

  @clients @staff @authenticate @bogus
  Scenario: Create client with too few chars for client code
    Given I have no clients
      And I am on the new client page
    When I fill in "Name" with "Ruby on Rails"
      And I fill in "Client Code" with "R"
      And I press "Create Client"
    Then I should see "Client code is too short"
      And I should have 0 clients

  @clients @staff @authenticate @edit
  Scenario: Check that the project form is hidden when editing a client
    Given I have client codes AAI
      And I am on the edit page for the client "AAI"
    Then the "Client Code" field should contain "AAI"
      And I should not see "First Project"
    When I fill in "Name" with "Mister Mittons"
      And I press "Update Client"
    Then I should be on the client page for "AAI"
      And I should see "Mister Mittons"

  @clients @edit @fail
  Scenario: Check that the form re-renders properly when edit fails
    Given I have client codes AAI
      And I am on the edit page for the client "AAI"
    When I fill in "Client Code" with ""
      And I press "Update Client"
    Then I should see "Client code can't be blank"
      And I should see "Name"
      And I should see "Client Code"
      And I should see "Logo"
      And I should see "Notes"
      And I should not see "Project Name"
      And I should not see "Project Domain"

  @clients @admin @authenticate @delete
  Scenario: Delete a client
    Given I have client codes ROR
      And I am on the client page for "ROR"
    Then I should not see "Delete this client" 
