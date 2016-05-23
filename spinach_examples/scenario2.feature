Feature: Test how spinach works for second test
  Scenario: Informal greeting
    Given I have an empty array
    And I append only my first name to it
    When I pass it to my super-duper method
    Then the output should contain a casual greeting
