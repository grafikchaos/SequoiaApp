@favorites
Feature: Favorites
  In order to find our information quickly
  As a staff member
  I want to be able to flag query strings, clients, and projects
  
  Background: Make sure I'm logged in
    Given I am logged in as a user
    And I have client codes AA, AAA, AAI, ROR
    And the client "ROR" has a default project named "Intranet" with domain "intranet.com" 
    And I am on the home page
    And I have no favorites

  @delete @focus @selenium
  Scenario: Viewing my bookmarks
    When I follow "Favorites"
    And I follow "View favorites"
    Then I should have 2 favorites
    And I should see "AAI Company Name Here"
    And I should see "ROR Company Name Here"
    And I should not see "AA Company Name Here"
    And I should not see "AAA Company Name Here"
    
