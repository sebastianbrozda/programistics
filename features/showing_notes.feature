Feature: Showing notes

  Background:
    Given there are notes:
      | id | title               | user_name  | body              | note_type_id | tags       |
      | 1  | title 1-1 public    | user_name1 | body1 public      | 1            | tag1, tag2 |
      | 2  | title 1-2 private   | user_name1 | body1 private     | 1            | tag3, tag4 |
      | 3  | title 2             | user_name2 | body2             | 1            | tag1       |
      | 4  | title 3             | user_name3 | body3             | 2            | tag1       |
      | 5  | title 4             | user_name4 | body4             | 1            | tag2       |
      | 6  | title 5 paid access | user_name4 | body5 paid access | 3            | tag2       |

  Scenario: Show public notes for not logged user
    When I visit the home page
    Then I should see "title 1-1"
    And I should see "title 2"
    And I should not see "title 3"
    And I should see "user_name1"

  Scenario: Show public note details
    Given I visit the home page
    When I click "title 1-1" link
    Then I should be redirected to the note details "title 1-1 public"
    And I should see "title 1-1"
    And I should see "user_name1"
    And I should see "tag1"
    And I should see "tag2"

  Scenario: Show only my own notes
    Given I am logged in
    When I visit the my notes page
    Then I should see only my notes

  Scenario: Not logged access wants to see note with paid access
    Given I visit the home page
    When I click "title 5 paid access" link
    Then I should be redirected to the note details "title 5 paid access"
    And I should not see "body5 paid access"
    And I should see "purchase access to see this note"

  Scenario: User without access wants to see note with paid access
    Given I am logged in
    And I visit the home page
    When I click "title 5 paid access" link
    Then I should be redirected to the note details "title 5 paid access"
    And I should not see "body5 paid access"
    And I should see "purchase access to see this note"

  Scenario: User with access wants to see paid access note
    Given I am logged in
    And I have paid access to note "title 5 paid access"
    When I visit the home page
    And I click "title 5 paid access" link
    Then I should be redirected to the note details "title 5 paid access"
    And I should see "body5 paid access"
