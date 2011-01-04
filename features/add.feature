Feature: Adding keys
  As a developer
  I want to add an API key
  So I can push gems as a different user

  Scenario Outline: Adding a new key
    Given a valid gemcutter account
    When I run "gem keys <command> <key>" interactively
    And I type "josh@vitamin-j.com"
    And I type "12345"
    Then the output should contain "Added <key> rubygems API key"
    And I should have a "<key>" rubygems key
    And the "<key>" rubygems key should be the response body

    Examples:
      |command|key     |
      |-a     |personal|
      |--add  |work    |

  Scenario: Adding a key with bad credentials
    Given an invalid gemcutter account
    When I run "gem keys -a bogus" interactively
    And I type "josh@vitamin-j.com"
    And I type "12345"
    Then the output should contain "Access denied"
    And I should not have a "bogus" rubygems key
