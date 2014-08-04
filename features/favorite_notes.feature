Feature: Favorite

  Background:
    Given there are notes:
      | id | title                 | user_name  | body  | note_type_id | tags       |
      | 1  | ruby on rails         | user_name2 | body2 | 1            | tag1, tag2 |

  @javascript
  Scenario: Add note to favorites
    Given I added note to favorites
    Then add button should hide but remove button should appear
    When I visit the my favorite notes page
    Then I should see "ruby on rails"

  @javascript
  Scenario: Display remove button if user has note in favorites
    Given I added note to favorites
    And I visit the home page
    When I click "ruby on rails" link
    And I wait 2 seconds
    Then "app-remove-note-from-favorites" should be visible

  @javascript
  Scenario: Remove note from favorites
    Given I added note to favorites
    When I click "app-remove-note-from-favorites" button
    Then add button should appear but remove button should hide
    When I visit the my favorite notes page
    Then I should not see "ruby on rails"

  @javascript
  Scenario: Not logged user tries to add note to favorites
    Given I visit the home page
    When I click "ruby on rails" link
    Then I should not see "app-add-note-to-favorites"
    And I wait 1 seconds