@abilities
Feature: Abilities - Roles and Permissions
  In order to restrict what resources users may create, read, update or delete
  As a fan of flexible ACLs
  I want to be able to define what each role has permission to do with a resource

  Background:
    Given the following user records
      | username               | password           | role    | clearance |
      | buttercup              | princess           | staff   | 3         |
      | valerie                | imnotawitch        | staff   | 2         |
      | theimpressiveclergyman | truwuv             | staff   | 1         |
      | humperdinck            | tothedeath         | staff   | 0         |
      | miraclemax             | toblave            | manager | 1         |
      | vizzini                | inconceivable      | manager | 2         |
      | sixfingeredman         | stopsayingthat     | manager | 3         |
      | dreadpirateroberts     | asyouwish          | admin   | 1         |
      | inigo                  | preparetodie       | admin   | 2         |
      | fezzik                 | anybodywantapeanut | admin   | 3         |
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

  @admin @entityTypes @view
  Scenario: Admins can view a list of Entity Types
    Given I am logged in as "dreadpirateroberts" with password "asyouwish"
    And I am on the home page
    When I follow "Admin"
    And I follow "Entity Types"
    Then I should see "ftp"
    And I should see "wireless"

  @admin @entityTypes @create
  Scenario: Admins can see create link for Entity Types
    Given I am logged in as "dreadpirateroberts" with password "asyouwish"
    When I go to the list of Entity Types
    Then I should see "New Entity Type"

  @admin @entityTypes @aliases
  Scenario: Entity Type Alias form fields are present in the Entity Type form
    Given I am logged in as "dreadpirateroberts" with password "asyouwish"
    When I go to the new Entity Type page
    Then I should see "Alias"
    And I should see "Add another"

  @admin @entityTypes @create
  Scenario: Admins can create Entity Types
    Given I am logged in as "dreadpirateroberts" with password "asyouwish"
    And I have no entity_types
    And I am on the new Entity Type page
    When I fill in "Name" with "API"
    And I press "Create Entity type"
    Then I should see "Entity Type was successfully created"
    And I should be on the list of Entity Types
    And I should see "API"
    And I should have 1 entity_type

  @admin @entityTypes @create @aliases
  Scenario: Admins can create Entity Types with known aliases
    Given I am logged in as "dreadpirateroberts" with password "asyouwish"
    And I have no entity_types
    And I have no entity_type_aliases
    And I am on the new Entity Type page
    When I fill in "Name" with "Database"
    And I fill in "entity_type[entity_type_aliases_attributes][0][name]" with "mysql"
    And I press "Create Entity type"
    Then I should see "Entity Type was successfully created"
    And I should be on the list of Entity Types
    And I should have 1 entity_type_aliases

  @admin @entityTypes @aliases  
  Scenario: Admins cannot create Entity Types where name already exists as alias
    Given I am logged in as "dreadpirateroberts" with password "asyouwish"
    And I am on the new Entity Type page
    When I fill in "Name" with "mysql"
    And I press "Create Entity type"
    Then I should see "Mysql is already an alias of entity type database"

  @admin @entityTypes @aliases
  Scenario: Admins cannot create Aliases where name is already an Entity Type (reverse of above)
    Given I am logged in as "dreadpirateroberts" with password "asyouwish"
    And I am on the new Entity Type page
    When I fill in "Name" with "Test Entity Type"
    And I fill in "entity_type[entity_type_aliases_attributes][0][name]" with "Database"
    And I press "Create Entity type"
    Then I should see "database is already an entity type"

  @admin @entityTypes @aliases @debug @javascript
  Scenario: Admins can delete aliases from an entity type
    Given I am logged in as "dreadpirateroberts" with password "asyouwish"
    # And I have no entity_type_aliases
    And I am on the edit Entity Type page for "Database"
    # When I fill in "entity_type[entity_type_aliases_attributes][0][name]" with "MySQL"
    # And I press "Update Entity type"
    # And I follow "edit-database"
    # Then show me the page
    # Then I should see "Delete mysql"
    # When I follow "//a[@id='delete-alias-mysql']"
    When I follow "Delete mysql"
    # Then show me the page
    # And I delete the Entity Type Alias "entity_type_entity_type_aliases_attributes_0__destroy"
    And I press "Update Entity type"
    Then I should be on the list of Entity Types
    And I should not see "mysql"
    # And I should have 0 entity_type_aliases

  @admin @entityTypes @edit
  Scenario: Admins can see edit link for Entity Types
    Given I am logged in as "dreadpirateroberts" with password "asyouwish"
    And I should have 1 entity_type
    When I go to the list of Entity Types
    Then I should see "Edit"

  @admin @entityTypes @edit
  Scenario: Admins can edit Entity Types
    Given I am logged in as "dreadpirateroberts" with password "asyouwish"
    And I am on the edit Entity Type page for "API"
    When I fill in "Name" with "APES"
    And I press "Update Entity type"
    Then I should see "Entity Type was successfully updated"
    And I should be on the list of Entity Types
    And I should see "APES"
    And I should not see "API"
    
  @entityTypes @delete
  Scenario: Admins can delete Entity Types
    Given I am logged in as "dreadpirateroberts" with password "asyouwish"
    And I am on the list of Entity Types
    When I follow "delete-payment-gateway"
    Then I should be on the list of Entity Types
    And I should see "Entity Type was successfully deleted"
    And I should not see "payment gateway"

  @entityTypes @auth
  Scenario: Only admins can see a list of Entity Types
    Given I am logged in as "buttercup" with password "princess"
    When I go to the list of Entity Types
    Then I should see "Access Denied"

  @admin @entityKeys @view
  Scenario: Admins can view a list of Entity Keys
    Given I am logged in as "dreadpirateroberts" with password "asyouwish"
    And I am on the home page
    When I follow "Admin"
    Then I should see "endpoint url"
    And I should see "encryption key"

  @entityKeys @create
  Scenario: Admins can create Entity Keys
    Given I am logged in as "dreadpirateroberts" with password "asyouwish"
    And I have no entity_keys
    And I am on the list of Entity Keys
    When I follow "New Entity Key"
    And I fill in "Name" with "Poison"
    And I press "Create Entity key"
    Then I should see "Entity Key was successfully created"
    And I should be on the list of Entity Keys
    And I should see "Poison"
    And I should have 1 entity_key

  @entityKeys @create @fail
  Scenario: Validate presence of the name attribute for EntityKey
    Given I am logged in as "dreadpirateroberts" with password "asyouwish"
    And I have no entity_keys
    And I am on the list of Entity Keys
    When I follow "New Entity Key"
    And I fill in "Name" with ""
    And I press "Create Entity key"
    Then I should see "1 error prohibited this entity_key from being saved:"
    And I should see "Name can't be blank"
    
  @entityKeys @create @fail
  Scenario: Validate uniqueness of the name attribute for EntityKey with matching case
    Given I am logged in as "dreadpirateroberts" with password "asyouwish"
    And I am on the list of Entity Keys
    When I follow "New Entity Key"
    And I fill in "Name" with "Username"
    And I press "Create Entity key"
    Then I should see "1 error prohibited this entity_key from being saved:"
    And I should see "Name has already been taken"

  @entityKeys @create @fail
  Scenario: Validate uniqueness of the name attribute for EntityKey with non-matching case
    Given I am logged in as "dreadpirateroberts" with password "asyouwish"
    And I am on the list of Entity Keys
    When I follow "New Entity Key"
    And I fill in "Name" with "username"
    And I press "Create Entity key"
    Then I should see "1 error prohibited this entity_key from being saved:"
    And I should see "Name has already been taken"
  

  @entityKeys @edit
  Scenario: Admins can edit Entity Keys
    Given I am logged in as "dreadpirateroberts" with password "asyouwish"
    And I am on the list of Entity Keys
    When I follow "edit-database-name"
    And I fill in "Name" with "Ponytail"
    And I press "Update Entity key"
    Then I should see "Entity Key was successfully updated"
    And I should be on the list of Entity Keys
    And I should see "Ponytail"
    And I should not see "database name"

  @entityKeys @delete
  Scenario: Admins can delete Entity Keys
    Given I am logged in as "dreadpirateroberts" with password "asyouwish"
    And I am on the list of Entity Keys
    When I follow "delete-transaction-key"
    Then I should be on the list of Entity Keys
    And I should see "Entity Key was successfully deleted"
    And I should not see "transaction key"

  @entityKeys @auth
  Scenario: Only admins can view Entity Keys
    Given I am logged in as "buttercup" with password "princess"
    When I go to the list of Entity Keys
    Then I should see "Access Denied"

  @users @view
  Scenario: Admins can see a list of users
    Given I am logged in as "dreadpirateroberts" with password "asyouwish"
    And I am on the home page
    When I follow "Admin"
    And I follow "Users"
    Then I should see "miraclemax"
    And I should see "fezzik"

  @users @create
  Scenario: Admins can create Users
    Given I am logged in as "dreadpirateroberts" with password "asyouwish"
    And I am on the list of Users
    When I follow "New User"
    And I fill in "Username" with "tester"
    And I fill in "Email" with "tester@tester.com"
    And I select "Staff" from "Role"
    And I select "Level 3" from "Clearance"
    And I fill in "Password" with "tester2"
    And I fill in "Password confirmation" with "tester2"
    And I press "Create User"
    Then I should be on the list of Users
    And I should see "tester"

  @users @fail
  Scenario: Form re-renders correctly when the create fails
    Given I am logged in as "dreadpirateroberts" with password "asyouwish"
    And I am on the list of Users
    When I follow "New User"
    And I fill in "Username" with "tester"
    And I select "Staff" from "Role"
    And I select "Level 3" from "Clearance"
    And I fill in "Password" with "tester2"
    And I fill in "Password confirmation" with "tester2"
    And I press "Create User"
    Then I should see "Email can't be blank"
    And I should see "Username"
    And I should see "Email"
    And I should see "Role"
    And I should see "Clearance"
    And I should see "Password"
    And I should see "Password confirmation"

  @users @edit
  Scenario: Admins can edit Users
    Given I am logged in as "dreadpirateroberts" with password "asyouwish"
    And I am on the list of Users
    When I follow "edit-inigo"
    And I fill in "Username" with "mandypatinkin"
    And I press "Update User"
    Then I should be on the list of Users
    And I should see "mandypatinkin"
    And I should not see "inigo"
    
  @users @fail
  Scenario: Form re-renders correctly when the create fails
    Given I am logged in as "dreadpirateroberts" with password "asyouwish"
    And I am on the list of Users
    And I follow "edit-fezzik"
    When I fill in "Email" with ""
    And I press "Update User"
    Then I should see "Email can't be blank"
    And I should see "Username"
    And I should see "Email"
    And I should see "Role"
    And I should see "Clearance"
    And I should see "Password"
    And I should see "Password confirmation"

  @users @delete
  Scenario: Admins can delete Users
    Given I am logged in as "dreadpirateroberts" with password "asyouwish"
    And I am on the list of Users
    When I follow "delete-inigo"
    Then I should be on the list of Users
    And I should not see "inigo"

  @users @own @jake
  Scenario: A user can edit their own account
    Given I am logged in as "buttercup" with password "princess"
    And I am on the home page
    When I follow "Account"
    Then I should see "Edit Your Account"
    When I fill in "Last name" with "Robertson"
    And I press "Update User"
    Then I should be on the account page for "buttercup"
    And the "Last name" field should contain "Robertson"

  @users @own @jake @todo!
  Scenario: Staff members cannot edit other users' accounts

  @users @lockable @wip
  Scenario: Admins can unlock locked user accounts

  @users @edit
  Scenario: Admins can set a clearance level for a user
    Given I am logged in as "dreadpirateroberts" with password "asyouwish"
    And I am on the list of Users
    When I follow "edit-inigo"
    And I select "Level 1" from "Clearance"
    And I press "Update User"
    Then I should be on the list of Users
    And I should see the following users
      | Username               | Clearance | Role    | Actions                         |
      | buttercup              | Level 3   | staff   | Edit this User Delete this User |
      | valerie                | Level 2   | staff   | Edit this User Delete this User |
      | theimpressiveclergyman | Level 1   | staff   | Edit this User Delete this User |
      | humperdinck            | Level 0   | staff   | Edit this User Delete this User |
      | miraclemax             | Level 1   | manager | Edit this User Delete this User |
      | vizzini                | Level 2   | manager | Edit this User Delete this User |
      | sixfingeredman         | Level 3   | manager | Edit this User Delete this User |
      | dreadpirateroberts     | Level 1   | admin   | Edit this User                  |
      | inigo                  | Level 1   | admin   | Edit this User Delete this User |
      | fezzik                 | Level 3   | admin   | Edit this User Delete this User |

  @users @clearance
  Scenario: Admins cannot grant a clearance level greater than their own
    Given I am logged in as "inigo" with password "preparetodie"
    And I am on the list of Users
    When I follow "edit-buttercup"
    Then I should see "Level 3" within "#user_clearance"
    And I should see "Level 2" within "#user_clearance"
    And I should not see "Level 1" within "#user_clearance"
    And I should not see "Level 0" within "#user_clearance"

  @users @auth
  Scenario: Only admins can see a list of users
    Given I am logged in as "buttercup" with password "princess"
    When I go to the list of Users
    Then I should see "Access Denied"

  @wip
  Scenario: Admins can create Entities

  @wip
  Scenario: Admins can edit Entities
    
  @wip
  Scenario: Admins can delete Entities


  @wip
  Scenario: Admins can edit Clients
    
  @clients
  Scenario: Admins can delete Clients
    Given I am logged in as "inigo" with password "preparetodie"
    And I have client codes ROR
    And I am on the client page for "ROR"
    When I follow "delete-ror"
    Then I should be on the search results page
    And I should have 0 clients

  @wip
  Scenario: Admins can create Projects

  @wip
  Scenario: Admins can edit Projects

  @wip
  Scenario: Only Admins can create Admins
  
  
  
  
  
  
