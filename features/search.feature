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
    And the following entity_type_alias records
      | type            | aliases                           |
      | application     | app                               |
      | computer        | machine, pc, desktop, laptop, mac |
      | database        | mysql, mongodb, sql               |
      | email           | mail                              |
      | ftp             | sftp                              |
      | ssh             | shell                             |
      | version control | vcs, svn, subversion, dvcs, git   |
      | website         | site                              |
      | wireless        | wifi, wep, wpa                    |
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
      | client | project  | name              | type            |
      | AAI    | Default  | external svn user | version control |
      | ROR    | Intranet | SSH Credentials   | ssh             |
      | ROR    | Intranet | Admin Login       | application     |
      | ROR    | Intranet | User Login        | application     |
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

  @advanced_search @invalid
  Scenario Outline: Invalid Advanced Search: Searching for an Entity by client code with a symbol other than '$' in front of client code
    When I fill in "query" with "<search string>"
    And I press "Search"
    Then I should not see "ROR"
    And I should not see "Admin Login"
    And I should not see "User Login"
    
    Examples:
      | search string |
      | $ ror login   |
      | `ror login    |
      | ~ror login    |
      | !ror login    |
      | #ror login    |
      | @ror login    |
      | :ror login    |
      | %ror login    |
      | ^ror login    |
      | &ror login    |
      | *ror login    |
      | (ror login    |
      | )ror login    |
      | 'ror login    |
      | =ror login    |
      | +ror login    |
      | -ror login    |
      | /ror login    |
      | \ror login    |
      | [ror login    |
      | ]ror login    |
      | {ror login    |
      | }ror login    |
      | <ror login    |
      | >ror login    |
      | ?ror login    |
      | ;ror login    |

  
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

  @advanced_search
  Scenario: Searching for an Entities by one client code and multiple EntityTypes
    When I fill in "query" with "$ror #ssh #application"
    And I press "Search"
    Then I should see "ROR"
    And I should see "SSH Credentials"
    And I should see "rubyonrails"
    And I should see "Admin Login"
    And I should see "admin"
    And I should see "User Login"
    And I should see "roruser"
  
  @advanced_search
  Scenario: Searching for an Entities by one client code and multiple EntityTypes and filtering by Entity name of last EntityType
    When I fill in "query" with "$ror #ssh #application admin"
    And I press "Search"
    Then I should see "ROR"
    And I should see "SSH Credentials"
    And I should see "rubyonrails"
    And I should see "Admin Login"
    And I should see "admin"
    And I should not see "User Login"
    And I should not see "roruser"

  @advanced_search
  Scenario: Searching for an Entities by one client code and multiple EntityTypes and filtering by Entity name of first EntityType
    When I fill in "query" with "$ror #application admin #ssh"
    And I press "Search"
    Then I should see "ROR"
    And I should see "SSH Credentials"
    And I should see "rubyonrails"
    And I should see "Admin Login"
    And I should see "admin"
    And I should not see "User Login"
    And I should not see "roruser"
  
  @advanced_search
  Scenario: Searching for an Entity by client code and EntityTypeAlias.name
    When I fill in "query" with "$ror #shell"
    And I press "Search"
    Then I should see "ROR"
    And I should see "SSH Credentials"
    And I should see "rubyonrails"
  
  @advanced_search
  Scenario: Searching for all Entities with multiple client codes
    When I fill in "query" with "$aai $ror"
    And I press "Search"
    Then I should see "AAI"
    And I should see "ROR"
    And I should see "external svn user"
    And I should see "deploy"
    And I should see "SSH Credentials"
    And I should see "rubyonrails"
    And I should see "Admin Login"
    And I should see "admin"
    And I should see "User Login"
    And I should see "roruser"

  @advanced_search @todo
    Scenario: Searching for an Entities by one client code and Entity Type second
      When I fill in "query" with "$ror admin #ssh"
      And I press "Search"
      Then I should see "ROR"
      And I should see "SSH Credentials"
      And I should see "rubyonrails"
      And I should see "Admin Login"
      And I should see "admin"
      And I should not see "User Login"
      And I should not see "roruser"

  @advanced_search @now
    Scenario: Advanced searches should save a QueryString object
      Given I have no query_strings
      When I fill in "query" with "$ror #ssh"
      And I press "Search"
      Then I should have 1 query_string

  @advanced_search @now
    Scenario: Regular searches should not save a QueryString object
      Given I have no query_strings
      When I fill in "query" with "aai"
      And I press "Search"
      Then I should have 0 query_strings
