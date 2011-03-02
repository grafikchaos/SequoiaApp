@search
Feature: Searching
  In order to find our information quickly
  As a staff member
  I want to be able to make complex searches against clients, projects, and entities
  
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
      | name            | mask  |
      | api key         | false |
      | database name   | false |
      | domain          | false |
      | email address   | false |
      | encryption key  | false |
      | endpoint url    | false |
      | host            | false |
      | password        | false |
      | port            | true  |
      | protocol        | true  |
      | token           | false |
      | transaction key | false |
      | url             | false |
      | username        | false |
      | wsdl url        | false |
    And the following Entities exist
      | client | project  | name              | type            | level |
      | AAI    | Default  | external svn user | version control | 2     |
      | ROR    | Intranet | SSH Credentials   | ssh             | 1     |
      | ROR    | Intranet | Admin Login       | application     | 2     |
      | ROR    | Intranet | User Login        | application     | 3     |
    And the following Entity Rows exist
      | client | project  | entity            | key      | value       |
      | AAI    | Default  | external svn user | username | deploy      |
      | AAI    | Default  | external svn user | password | launchpad!  |
      | ROR    | Intranet | SSH Credentials   | username | rubyonrails |
      | ROR    | Intranet | SSH Credentials   | password | secret      |
      | ROR    | Intranet | Admin Login       | username | admin       |
      | ROR    | Intranet | Admin Login       | password | secret      |
      | ROR    | Intranet | User Login        | username | roruser     |
      | ROR    | Intranet | User Login        | password | secret      |
    And I am on the home page
    

  @clients
  Scenario: Search Clients by client code
    When I fill in "query" with "AA"
    And I press "Search"
    Then I should see "AA"
    And I should see "AAA"
    And I should see "AAI"
    And I should not see "ROR"
  
  @projects
  Scenario: Searching for a client by project domain name
    When I fill in "query" with "intran"
    And I press "Search"
    Then I should see "ROR"


  @advanced_search
  Scenario: Searching for an Entity by client code and Entity.name
    When I fill in "query" with "$ror login"
    And I press "Search"
    Then I should see "ROR"
    And I should see "Admin Login"
    And I should see "User Login"
  
  @advanced_search
  Scenario: Searching for an Entity by client code and EntityRow.value (:encrypted_value)
    When I fill in "query" with "$ror admin"
    And I press "Search"
    Then I should see "ROR"
    And I should see "Admin Login"
    And I should see "admin"
    
  @advanced_search
  Scenario: Searching for an Entity by client code and EntityType.name
    When I fill in "query" with "$ror #ssh"
    And I press "Search"
    Then I should see "ROR"
    And I should see "SSH Credentials"
    And I should see "rubyonrails"
  
