Feature: Adding keys
  As a developer
  I want to add an API key
  So I can push gems as a different user

  Scenario Outline: Adding a new key
    Given a valid gemcutter account
    When I run "gem keys <command> <key>" interactively
    And I type "josh@vitamin-j.com"
    And I type "12345"
    Then the output should contain "Added <key> API key"
    And I should have a "<key>" api key
    And the "<key>" api key should be the response body

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
    And I should not have a "bogus" api key

  @1.4
  Scenario: Adding a key from a compatible host
    Given a gemcutter host at "https://nubygems.org"
    And a valid gemcutter account
    When I run "gem keys --add personal --host https://nubygems.org" interactively
    And I type "josh@vitamin-j.com"
    And I type "12345"
    Then the output should contain "Enter your nubygems.org credentials"
    And the "personal" api key should be the response body
