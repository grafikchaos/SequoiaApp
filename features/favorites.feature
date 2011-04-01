@favorites
Feature: Favorites
  In order to find our information quickly
  As a staff member
  I want to be able to flag query strings, clients, and projects
  
  Background: Make sure I'm logged in
    Given I am logged in as a user
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
      And I have no favorites

  @view
  Scenario: I can see favorites link
    Given I am on the home page
    Then I should see "View All" within "#sidebar .favorites"

  @javascript @new @josh
  Scenario: Bookmark a client
    Given I am on the home page
    When I fill in "query" with "AAI"
      And I press "Search"
      And I favorite the 1st item in the list
      And I go to the list of my favorites
    Then I should see "AAI Company Name Here"
      And "user" should have 1 favorite

  @javascript @new
  Scenario: Bookmark a query string
    Given I am on the home page
      And the following Entities exist
        | client | project  | name            | type        | level |
        | ROR    | Intranet | SSH Credentials | ssh         | 2     |
        | ROR    | Intranet | Admin Login     | application | 3     |
        | ROR    | Intranet | User Login      | application | 3     |
    When I fill in "query" with "$aai $ror"
      And I press "Search"
      And I favorite the query string
      And I go to the list of my favorites
    Then I should see "$aai $ror"
      And "user" should have 1 favorite

  @edit
  Scenario: I can edit my bookmarks
    Given "user" has bookmarked the Client "ROR"
      And "user" has bookmarked the Client "AAI"
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
    Given "user" has bookmarked the Client "ROR"
      And "user" has bookmarked the Client "AAI"
    When I go to the list of my favorites
      And I follow "delete-ror_company_name_here"
    Then I should be on the list of my favorites
      And I should not see "ROR Company Name Here"
      And I should have 1 favorites

  @filtering @wip
  Scenario: I can filter my bookmarks
    Given "user" has bookmarked the Client "ROR"
      And "user" has bookmarked the Client "AAI"
      And I am on the home page
    When I fill in "fav-filter" with "ROR"
    Then I should see "ROR Company Name Here" within "#sidebar .favorites"
      And I should not see "AAI Company Name Here" within "#sidebar .favorites"
      And I should have 2 favorites
