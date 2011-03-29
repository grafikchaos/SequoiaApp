@favorites
Feature: Favorites
  In order to find our information quickly
  As a staff member
  I want to be able to flag query strings, clients, and projects
  
  Background: Make sure I'm logged in
    Given I am logged in as a user
    And I have client codes AA, AAA, AAI, ROR
    And the client "ROR" has a default project named "Intranet" with domain "intranet.com" 
    And I have no favorites

  @view @javascript
  Scenario: I can see favorites link
    Given I am on the home page
    Then I should see "Favorites" within "#user-navigation"

  @javascript @new @wip
  Scenario: Bookmark a client
    Given I am on the home page
    When I fill in "query" with "AAI"
    And I press "Search"
    
