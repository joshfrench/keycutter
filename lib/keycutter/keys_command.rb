require 'rubygems/command'
require 'rubygems/gemcutter_utilities'

class Gem::Commands::KeysCommand < Gem::Command
  include Gem::GemcutterUtilities

  def initialize
    super 'keys', "Adds management for multiple gemcutter accounts"

    add_option '-l', '--list', 'List keys' do |value,options|
      options[:list] = value
    end

    add_option '-u', '--use KEYNAME', 'Use the given API key' do |value,options|
      options[:use] = value
    end

    add_option '-r', '--remove KEYNAME', 'Remove the given API key' do |value,options|
      options[:remove] = value
    end

    add_option '-a', '--add KEYNAME', 'Add an API key with the given name' do |value,options|
      options[:add] = value
    end
  end

  def arguments
    "KEYNAME          name of a Rubygems API key"
  end

  def defaults_str
    "--list"
  end

  def usage
    "#{program_name} [options] [KEYNAME]"
  end

  def execute
    options[:list] = !(options[:use] || options[:remove] || options[:add])

    if options[:add] then
      say "Enter your RubyGems.org credentials."
      say "Don't have an account yet? Create one at http://rubygems.org/sign_up"

      email    =              ask "   Email: "
      password = ask_for_password "Password: "
      say

      response = rubygems_api_request :get, "api/v1/api_key" do |request|
        request.basic_auth email, password
      end

      with_response response do |resp|
        accounts = Gem.configuration.rubygems_accounts.merge(options[:add] => resp.body)
        Gem.configuration.rubygems_accounts = accounts
        say "Added #{options[:add]} rubygems API key"
      end
    end

    if options[:remove] then
      accounts = Gem.configuration.rubygems_accounts
      if accounts.has_key? options[:remove]
        accounts.delete(options[:remove])
        Gem.configuration.rubygems_accounts = accounts
        say "Removed #{options[:remove]} rubygems API key"
      else
        say "No such rubygems API key"
        terminate_interaction 1
      end
    end

    if options[:use] then
      if Gem.configuration.rubygems_accounts.has_key? options[:use]
        Gem.configuration.rubygems_api_key = Gem.configuration.rubygems_accounts[options[:use]]
        say "Now using #{options[:use]} rubygems API key"
      else
        say "No such rubygems API key. You can add it with: gem keys -a #{options[:use]}"
        terminate_interaction 1
      end
    end

    if options[:list] then
      say "*** CURRENT KEYS ***"
      say
      accounts = Gem.configuration.rubygems_accounts.sort
      accounts.each do |account|
        name, key = account
        say "%2s %s" % [Gem.configuration.rubygems_api_key[key] && '*', name]
      end
    end
  end
end
