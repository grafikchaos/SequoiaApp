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
  
  @wip
  Scenario: Create a client
  

  @wip
  Scenario: Edit a client


  @wip
  Scenario: Delete a client
  

  