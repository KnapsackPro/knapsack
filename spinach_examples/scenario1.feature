Feature: Test how spinach works for first test
  Scenario: Format greeting
    Given I have an empty array
    And I append my first name and my last name to it
    When I pass it to my super-duper method
    Then the output should contain a formal greeting
