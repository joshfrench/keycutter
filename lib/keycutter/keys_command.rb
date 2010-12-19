require 'rubygems/command'

class Gem::Commands::KeysCommand < Gem::Command
  def initialize
    super 'keys', "Adds management for multiple gemcutter accounts"

    add_option '-l', '--list', 'List keys' do |value,options|
      options[:list] = value
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
    options[:list] = true

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
