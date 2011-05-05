@abilities
Feature: Abilities - Roles and Permissions
  In order to restrict what resources users may create, read, update or delete
  As a fan of flexible ACLs
  I want to be able to define what each role has permission to do with a resource

  Background:
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
      | theinvisibleman        | ellison            | owner                 |
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
      And I press "Create Entity Type"
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
      And I press "Create Entity Type"
    Then I should see "Entity Type was successfully created"
      And I should be on the list of Entity Types
      And I should have 1 entity_type_aliases

  @admin @entityTypes @aliases  
  Scenario: Admins cannot create Entity Types where name already exists as alias
    Given I am logged in as "dreadpirateroberts" with password "asyouwish"
      And I am on the new Entity Type page
    When I fill in "Name" with "mysql"
      And I press "Create Entity Type"
    Then I should see "Mysql is already an alias of entity type database"

  @admin @entityTypes @aliases
  Scenario: Admins cannot create Aliases where name is already an Entity Type (reverse of above)
    Given I am logged in as "dreadpirateroberts" with password "asyouwish"
      And I am on the new Entity Type page
    When I fill in "Name" with "Test Entity Type"
      And I fill in "entity_type[entity_type_aliases_attributes][0][name]" with "Database"
      And I press "Create Entity Type"
    Then I should see "database is already an entity type"

  @admin @entityTypes @aliases @debug @javascript
  Scenario: Admins can delete aliases from an entity type
    Given I am logged in as "dreadpirateroberts" with password "asyouwish"
      And I am on the edit Entity Type page for "Database"
    When I follow "Delete mysql"
      And I press "Update Entity Type"
    Then I should be on the list of Entity Types
      And I should not see "mysql"

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
      And I press "Update Entity Type"
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
      And I press "Create Entity Key"
    Then I should see "Entity Key was successfully created"
      And I should be on the list of Entity Keys
      And I should see "Poison"
      And I should have 1 entity_key

  @entityKeys @create @fail
  Scenario: Validate presence and minimum length of the name attribute for EntityKey
    Given I am logged in as "dreadpirateroberts" with password "asyouwish"
      And I have no entity_keys
      And I am on the list of Entity Keys
    When I follow "New Entity Key"
      And I fill in "Name" with ""
      And I press "Create Entity Key"
    Then I should see "Name can't be blank"
      And I should see "Name is too short"
    
  @entityKeys @create @fail
  Scenario: Validate uniqueness of the name attribute for EntityKey with matching case
    Given I am logged in as "dreadpirateroberts" with password "asyouwish"
      And I am on the list of Entity Keys
    When I follow "New Entity Key"
      And I fill in "Name" with "Username"
      And I press "Create Entity Key"
    Then I should see "Name has already been taken"

  @entityKeys @create @fail
  Scenario: Validate uniqueness of the name attribute for EntityKey with non-matching case
    Given I am logged in as "dreadpirateroberts" with password "asyouwish"
      And I am on the list of Entity Keys
    When I follow "New Entity Key"
      And I fill in "Name" with "username"
      And I press "Create Entity Key"
    Then I should see "Name has already been taken"
  
  @entityKeys @edit
  Scenario: Admins can edit Entity Keys
    Given I am logged in as "dreadpirateroberts" with password "asyouwish"
      And I am on the list of Entity Keys
    When I follow "edit-database-name"
      And I fill in "Name" with "Ponytail"
      And I press "Update Entity Key"
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
      And I fill in "Full name" with "Test User"
      And I check "Staff"
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
      And I fill in "Full name" with ""
      And I check "Staff"
      And I fill in "Password" with "tester2"
      And I fill in "Password confirmation" with "tester2"
      And I press "Create User"
    Then I should see "Email can't be blank"
      And I should see "Full name can't be blank"
      And I should see "Full name is too short"
      And I should see "Username"
      And I should see "Email"
      And I should see "Roles"
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

  @users @edit @owner
  Scenario: No one can edit owners except owners
    Given I am logged in as "dreadpirateroberts" with password "asyouwish"
    When I go to the edit user page for "theinvisibleman"
    Then I should see "Access Denied"
    When I go to the edit user page for "buttercup"
    Then I should see "Editing buttercup"
    
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
      And I should see "Password"
      And I should see "Password confirmation"

  @users @delete
  Scenario: Admins can delete Users
    Given I am logged in as "dreadpirateroberts" with password "asyouwish"
      And I am on the list of Users
    When I follow "delete-inigo"
    Then I should be on the list of Users
      And I should not see "inigo"

  @users @own
  Scenario: A user can edit their own account
    Given I am logged in as "buttercup" with password "princess"
      And I am on the home page
    When I follow "Account"
    Then I should see "Edit Your Account"
    When I fill in "Full name" with "Julie Robertson"
      And I press "Update User"
    Then I should be on the list of Users

  @users @own
  Scenario: Staff members cannot edit other users' accounts
    Given I am logged in as "buttercup" with password "princess"
      And I am on the home page
    When I go to the account page of someone other than "buttercup"
    Then I should see "Access Denied"

  @users @lockable
  Scenario: Admins can unlock locked user accounts
    Given I am logged in as "dreadpirateroberts" with password "asyouwish"
      And the user "buttercup" is locked
      And I am on the list of Users
    When I follow "Unlock"
    Then I should be on the list of Users
      And I should see "User account has been unlocked."
      And I should not see "Unlock"

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
  
  
  
  
  
  
