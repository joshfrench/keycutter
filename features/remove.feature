Feature: Remove API keys
  As a developer
  I want to remove an old API key
  So I can get rid of cruft

  Background:
    Given I have the following api keys:
      |name    |key                             |
      |personal|11111111111111111111111111111111|
      |work    |22222222222222222222222222222222|

  Scenario Outline:
    When I run `gem keys <command> <key>`
    Then the output should contain "Removed <key> API key"
    And I should not have a "<key>" api key

    Examples:
      |command |key     |
      |-r      |personal|
      |--remove|work    |

  Scenario: Removing a bogus key
    When I run `gem keys -r bogus`
    Then the output should contain "No such API key"
