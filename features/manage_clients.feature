Feature: Manage Clients
  In order to efficiently access and store client data in our intranet
  As a staff member
  I want to create and manage clients
  
  # TODO: test this again maybe without javascript
  @wip
  Scenario: Search Clients by client code
    Given I have client codes AA, AAA, AAI
    When I search for "AA"
    Then I should see "AA"
    And I should see "AAA"
    And I should see "AAI"
  
  @clients @authenticate
  Scenario: Client form has project subform fields
    Given I am on the list of clients
    When I follow "New Client"
    Then I should see "Name"
    And I should see "Client Code"
    And I should see "Project Name"
    And I should see "Project Domain"
    
  
  @clients @staff
  Scenario: Create a valid client
    Given the client "ROR" does not exist
    And I am on the new client page
    When I fill in "Name" with "Ruby on Rails"
    And I fill in "Client code" with "ROR"
    And I fill in "Project Name" with "Shallow Routing"
    And I fill in "Project Domain" with "Shallow Routing"
    And I press "Create Client"
    Then I should be on the client page for "ROR"
    And I should see "ROR"
    And I should see "Shallow Routing" within "#project"
    
  

  @wip
  Scenario: Edit a client


  @wip
  Scenario: Delete a client
  
  
  
  