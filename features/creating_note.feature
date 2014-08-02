Feature: Creating a note

  Background:
    Given I am logged in
    And I visit the note creation form

  Scenario: Valid public note creation
    Given I submit note creation form with valid data
    When I should be redirected to the newly created note
    Then I should see "Note has been created."

  Scenario: Invalid note creation
    Given I submit note creation form with invalid data
    Then I should see "Errors"

  Scenario: Not logged user
    Given I am not logged in
    When I visit the note creation form
    Then I should be redirected to the log in page
    And I should see "Please log in first"

  Scenario: User creates note with paid access
    Given I fill creation form to create paid access note
    And I submit note form creation
    When I should be redirected to the newly created note
    Then I should see "paid access" label and note body