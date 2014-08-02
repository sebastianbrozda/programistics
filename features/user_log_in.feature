Feature: User log in

  Scenario: Successful log in
    Given I visit the home page
    When I log in
    Then I should be redirected to the home page
    And I should see "Signed in successfully."