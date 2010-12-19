Feature: Default commands
  As a new user
  I want to find out what my options are
  So I can put keycutter to best use

  Background:
    Given I have installed keycutter

  Scenario: Installing the gem
    When I run "gem q"
    Then the output should contain "keycutter"

  Scenario: Calling the plugin with no options
    Given I have the following rubygems keys:
      |name    |key                             |
      |personal|11111111111111111111111111111111|
      |work    |22222222222222222222222222222222|
      |oss_1   |33333333333333333333333333333333|
      |oss_2   |44444444444444444444444444444444|
    And my current rubygems key is "personal"
    When I run "gem keys"
    Then the output should contain:
    """
    *** CURRENT KEYS ***

       oss_1
       oss_2
     * personal
       work
    """

  Scenario Outline: list
    Given I have the following rubygems keys:
      |name    |key                             |
      |personal|11111111111111111111111111111111|
      |work    |22222222222222222222222222222222|
    And my current rubygems key is "work"
    When I run "<command>"
    Then the output should contain:
    """
    *** CURRENT KEYS ***

       personal
     * work
    """

    Examples:
      |command         |
      |gem keys -l     |
      |gem keys --list |
