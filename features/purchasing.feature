Feature: Purchasing

  Background:
    Given there are notes:
      | id | title             | user_name  | body      | note_type_id | tags       | price_for_access |
      | 1  | title paid access | user_name5 | full body | 3            | tag1, tag2 | 10               |

  Scenario: Not logged user try to purchase access to note
    Given I visit the "title paid access" note page
    When I click "purchase" button
    Then I should be redirected to the log in page

  Scenario: Logged user already has access to note
    Given I am logged in
    And I have access to the "title paid access"
    And I visit the "title paid access" purchase page
    Then I should be redirected to the note details "title paid access"

  Scenario: Purchase access to note
    Given I am logged in
    When I visit the "title paid access" note page
    And I click "purchase" button
    Then I should be redirected to the note details "title paid access"
    And I should see coinbase iframe