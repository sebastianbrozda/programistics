Feature: My earnings

  Background:
    Given I am logged in
    And I visit the my earnings page

  Scenario: Empty list
    Given I should see "You earned nothing yet"

  Scenario: List is not empty
    Given there are payments:
      | note  | transaction_hash | price | status |
      | note1 | hash1            | 100   | 0      |
      | note2 | hash2            | 100   | 1      |
      | note3 | hash3            | 150   | 2      |
      | note4 | hash4            | 150   | 2      |
    When I visit the my earnings page
    Then I should see lists of my earnings
    And the summary earning

  Scenario: User is not logged in
    Given I am not logged in
    When I visit the my earnings page
    Then I should be redirected to the log in page