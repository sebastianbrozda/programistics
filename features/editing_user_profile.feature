Feature: Editing user profile

  Background:
    Given I am logged in
    And I visit the profile settings page

  Scenario: Update email
    When I try to change my email
    Then my email changes

  Scenario: Update bitcoin wallet
    When I change my bitcoin wallet
    Then my bitcoin wallet changes

  Scenario: Upload user avatar
    When I upload my new avatar
    Then my avatar changes