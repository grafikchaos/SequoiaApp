@errors
Feature: Error handling
  In order to ensure that we don't leave our users hanging
  As a user
  I want to be presented with a page corresponding to the HTTP/other error I come across

  Background:
    Given the following user records
      | username               | password           | roles                 |
      | dreadpirateroberts     | asyouwish          | admin, staff          |
    And I am logged in as "dreadpirateroberts" with password "asyouwish"
    
  Scenario: A 404 for page not found
    Given I am on the search results page
    When I go to a non-existent page
    Then I should see "The page you were looking for doesn't exist."
