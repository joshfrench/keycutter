Feature: Adding keys
  As a developer
  I want to add an API key
  So I can push gems as a different user

  Scenario Outline: Adding a new key
    When I run "gem keys <command> <key>" interactively
    And I type "josh@vitamin-j.com"
    And I type "12345"
    Then the output should contain "Added <key> rubygems API key"
    And I should have a "<key>" rubygems key

    Examples:
      |command|key     |
      |-a     |personal|
      |--add  |work    |
