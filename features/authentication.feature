Feature: Manage authentications
  In order to gain access to information
  the User
  wants to be able to log in
  
  Scenario: Login
    Given a user "user" exists
    And I am on the login page
    When I fill in "Username" with "user"
    And I fill in "Password" with "test1234"
    And I press "Sign in"
    Then I should see "Signed in successfully"
    And I should be on the home page
    And I should see "Logout"
  
  Scenario: Logout
    Given I am logged in as a user
    When I follow "Logout"
    Then I should be on the login page
