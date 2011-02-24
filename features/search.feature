@search
Feature: Searching
  In order to find our information quickly
  As a staff member
  I want to be able to make complex searches against clients, projects, and entities
  
  Background: Make sure I'm logged in
    Given I am logged in as a user
    And I have client codes AA, AAA, AAI, ROR
    And the client "ROR" has a default project named "Railties" with domain "intranet.com" 

  @clients
  Scenario: Search Clients by client code
    Given I am on the home page
    When I fill in "query" with "AA"
    And I press "Search"
    Then I should see "AA"
    And I should see "AAA"
    And I should see "AAI"
    And I should not see "ROR"
  
  @projects
  Scenario: Searching for a client by project domain name
    Given I am on the home page
    When I fill in "query" with "intran"
    And I press "Search"
    Then I should see "ROR"
