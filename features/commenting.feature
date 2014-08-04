Feature: Commenting

  Background:
    Given there are notes:
      | id | title                 | user_name  | body  | note_type_id | tags       |
      | 1  | ruby on rails         | user_name2 | body2 | 1            | tag1, tag2 |

  Scenario: Not logged user
    Given I visit the "ruby on rails" note page
    Then I should see "Log in to make a comment"

  Scenario: User is logged in s
    Given I am logged in
    When I visit the "ruby on rails" note page
    And I submit comment creation form with valid data for note
    Then I should see "Comment has been added"
    And I should see added comment