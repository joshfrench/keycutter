require 'rubygems/command_manager'

if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.3.6')
  Gem::CommandManager.instance.register_command :keys
end

