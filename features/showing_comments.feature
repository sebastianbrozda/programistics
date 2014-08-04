Feature: Showing comments

  Background:
    Given there are notes:
      | id | title  | user_name  | body      | note_type_id | tags       | price_for_access |
      | 1  | public | user_name5 | full body | 1            | tag1, tag2 | 0                |


  Scenario: Show comments


  Scenario: Show private note comments only for note author
