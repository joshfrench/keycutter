require 'rubygems/command'

class Gem::Commands::KeysCommand < Gem::Command
  def initialize
    super 'keys', "Adds management for multiple gemcutter accounts"

    add_option '-l', '--list', 'List keys' do |value,options|
      options[:list] = value
    end

    add_option '-u', '--use KEYNAME', 'Use the given API key' do |value,options|
      options[:use] = value
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
    options[:list] = !options[:use]

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
