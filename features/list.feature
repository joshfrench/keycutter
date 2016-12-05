Feature: Default commands
  As a new user
  I want to find out what my options are
  So I can put keycutter to best use

  Scenario: Installing the gem
    When I run `gem q`
    Then the output should contain "keycutter"

  Scenario: Calling the plugin with no options
    Given I have the following api keys:
      |name    |key                             |
      |rubygems|11111111111111111111111111111111|
      |work    |22222222222222222222222222222222|
      |oss_1   |33333333333333333333333333333333|
      |oss_2   |44444444444444444444444444444444|
    And my current rubygems key is "rubygems"
    When I run `gem keys`
    Then the output should contain:
    """
    *** CURRENT KEYS ***

       oss_1
       oss_2
     * rubygems
       work
    """

  Scenario Outline: Using the list option
    Given I have the following api keys:
      |name    |key                             |
      |rubygems|11111111111111111111111111111111|
      |work    |22222222222222222222222222222222|
    And my current rubygems key is "work"
    When I run `gem keys <option>`
    Then the output should contain:
    """
    *** CURRENT KEYS ***

       rubygems
     * work
    """

    Examples:
      |option |
      |-l     |
      |--list |
