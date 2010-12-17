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
    When I run "gem keys"
    Then the output should contain:
    """
    Usage: gem keys [option] [keyname]
    """
