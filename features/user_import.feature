Feature: Import Users

  Scenario: Successfully importing users from a CSV file
    Given I am on the import users page
    When I upload a CSV file with valid user data
    Then I should see the import results on the page without a full page reload
