@favorites
Feature: Favorites
  In order to find our information quickly
  As a staff member
  I want to be able to flag query strings, clients, and projects
  
  Background: Make sure I'm logged in
    Given the following user records
      | username               | password           | roles                 |
      | buttercup              | princess           | staff                 |
      | valerie                | imnotawitch        | staff                 |
      | theimpressiveclergyman | truwuv             | staff                 |
      | humperdinck            | tothedeath         | staff                 |
      | miraclemax             | toblave            | contractor            |
      | vizzini                | inconceivable      | staff, financial      |
      | sixfingeredman         | stopsayingthat     | contractor, financial |
      | dreadpirateroberts     | asyouwish          | admin, staff          |
      | inigo                  | preparetodie       | admin, staff          |
      | fezzik                 | anybodywantapeanut | admin, staff          |
      And I am logged in as "dreadpirateroberts" with password "asyouwish"
      And I have client codes AA, AAA, AAI, ROR
      And the client "ROR" has a default project named "Intranet" with domain "intranet.com" 
      And the following entity_type records
        | name            |
        | api             |
        | application     |
        | computer        |
        | database        |
        | email           |
        | ftp             |
        | payment gateway |
        | remote desktop  |
        | ssh             |
        | version control |
        | vpn             |
        | website         |
        | wireless        |
      And the following entity_key records
        | name            |
        | api key         |
        | database name   |
        | domain          |
        | email address   |
        | encryption key  |
        | endpoint url    |
        | host            |
        | password        |
        | port            |
        | protocol        |
        | token           |
        | transaction key |
        | url             |
        | username        |
        | wsdl url        |
      And the following Entities exist
        | client | project  | name              | type            | roles |
        | AAI    | Default  | external svn user | version control | staff |
        | ROR    | Intranet | SSH Credentials   | ssh             | staff | 
        | ROR    | Intranet | Admin Login       | application     | staff |
        | ROR    | Intranet | User Login        | application     | staff |
      And I have no favorites

  @view
  Scenario: I can see favorites link
    Given I am on the home page
    Then I should not see "Favorites" within "#sidebar"

  @javascript @new
  Scenario: Bookmark a client
    Given I am on the home page
    When I fill in "query" with "AAI"
      And I press "Search"
      And I favorite the 1st item in the list
      And I go to the list of my favorites
    Then I should have 1 favorite

  @javascript @new
  Scenario: Bookmark a query string
    Given I am on the home page
    When I fill in "query" with "$aai $ror"
      And I press "Search"
      And I favorite the query string
      And I go to the list of my favorites
    Then I should have 1 favorite

  @edit
  Scenario: I can edit my bookmarks
    Given "dreadpirateroberts" has bookmarked the Client "ROR"
      And "dreadpirateroberts" has bookmarked the Client "AAI"
    When I go to the list of my favorites
      And I follow "edit-ror_company_name_here"
      And I fill in "Name" with "Ruby on Rails is cool"
      And I press "Update Favorite"
    Then I should be on the list of my favorites
      And I should see "Ruby on Rails is cool"
      And I should not see "ROR Company Name Here"
      And I should have 2 favorites

  @delete
  Scenario: I can delete a bookmark
    Given "dreadpirateroberts" has bookmarked the Client "ROR"
      And "dreadpirateroberts" has bookmarked the Client "AAI"
    When I go to the list of my favorites
      And I follow "delete-ror_company_name_here"
    Then I should be on the list of my favorites
      And I should not see "ROR Company Name Here"
      And I should have 1 favorites

  @javascript @filtering
  Scenario: I can filter my bookmarks
    Given "dreadpirateroberts" has bookmarked the Client "ROR"
      And "dreadpirateroberts" has bookmarked the Client "AAI"
      And I am on the home page
    When I fill in "fav-filter" with "ROR"
    Then I should see "ROR Company Name Here" within "#sidebar .favorites"
      And I should not see "AAI Company Name Here" within "#sidebar .favorites"
      And I should have 2 favorites
