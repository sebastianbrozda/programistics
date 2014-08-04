Feature: Showing comments

  Background:
    Given there are notes:
      | id | title  | user_name  | body      | note_type_id | tags       | price_for_access |
      | 1  | public | user_name5 | full body | 1            | tag1, tag2 | 0                |
    And there are comments:
      | id | note_title | user_name  | comment           |
      | 1  | public     | user_name5 | this is a comment |

  Scenario: Show comments for not logged in
    Given I visit the "public" note page
    When I wait 1 seconds
    Then I should see "this is a comment"

