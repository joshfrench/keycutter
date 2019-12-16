require 'rubygems/gemcutter_utilities'

class Gem::Commands::KeysCommand < Gem::Command
  include Gem::GemcutterUtilities

  OptionParser.accept Symbol do |value|
    value.to_sym
  end

  def initialize
    super 'keys', "Adds management for multiple gemcutter accounts"

    add_option '-l', '--list', 'List keys' do |value,options|
      options[:list] = value
    end

    add_option '-d', '--default KEYNAME', Symbol, 'Set the default API key' do |value,options|
      options[:default] = value
    end

    add_option '-r', '--remove KEYNAME', Symbol, 'Remove the given API key' do |value,options|
      options[:remove] = value
    end

    add_option '-a', '--add KEYNAME', Symbol, 'Add an API key with the given name' do |value,options|
      options[:add] = value
    end

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.4.0')
      add_option '--host HOST', 'Use another gemcutter-compatible host' do |value,options|
        options[:host] = value
      end
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
    require 'keycutter'

    options[:list] = !(options[:default] || options[:remove] || options[:add])

    if options[:add] then
      if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.4.0')
        gem_host = URI.parse(options[:host] || Gem.host).host
      else
        gem_host = 'Rubygems.org'
      end

      say "Enter your #{gem_host} credentials."
      say "Don't have an account yet? Create one at http://rubygems.org/sign_up"

      email    =              ask "   Email: "
      password = ask_for_password "Password: "
      say

      args = [:get, 'api/v1/api_key']
      args << options[:host] if options[:host]

      response = rubygems_api_request(*args) do |request|
        request.basic_auth email, password
      end

      with_response response do |resp|
        accounts = Gem.configuration.api_keys.merge(options[:add] => resp.body)
        Gem.configuration.api_keys = accounts
        say "Added #{options[:add]} API key"
      end
    end

    if options[:remove] then
      accounts = Gem.configuration.api_keys
      if accounts.has_key? options[:remove]
        accounts.delete(options[:remove])
        Gem.configuration.api_keys = accounts
        say "Removed #{options[:remove]} API key"
      else
        say "No such API key"
      end
    end

    if options[:default] then
      if Gem.configuration.api_keys.has_key? options[:default]
        Gem.configuration.rubygems_api_key = Gem.configuration.api_keys[options[:default]]
        say "Now using #{options[:default]} API key"
      else
        say "No such API key. You can add it with: gem keys -a #{options[:default]}"
        terminate_interaction 1
      end
    end

    if options[:list] then
      say "*** CURRENT KEYS ***"
      say
      api_keys = Gem.configuration.api_keys.sort_by {|k,v| k.to_s}
      api_keys.each do |api_key|
        name, key = api_key
        say " #{Gem.configuration.rubygems_api_key == key ? '*' : ' '} #{name}"
      end
    end
  end
end
