Feature: Using gem keys
  As an open source developer
  I want to switch between rubygems API keys
  In order to push all of my sweet gems

  Background:
    Given I have the following api keys:
      |name    |key                             |
      |personal|11111111111111111111111111111111|
      |work    |22222222222222222222222222222222|

  Scenario Outline: Using a different key
    Given my current rubygems key is "work"
    When I run "gem keys <command> <key>"
    Then the output should contain "Now using <key> API key"
    And my current rubygems key should be "<key>"

    Examples:
      |command|key     |
      |-d     |personal|
      |--default  |personal|
      |-d     |work    |

  Scenario: Using a bogus key
    Given my current rubygems key is "personal"
    When I run "gem keys -d bogus"
    Then the output should contain "No such API key. You can add it with: gem keys -a bogus"
    And the exit status should be 1
    And my current rubygems key should be "personal"
