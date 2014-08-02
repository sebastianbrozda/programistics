Feature: User registration

  Scenario: Success registration
    Given I visit the user registration page
    When I fill in user details with valid data
    And I click "Sign up" button
    Then I should be redirected to the home page
    And I should see "Welcome!"
