AfterConfiguration do
  `rake build`
  `gem install pkg/keycutter-#{Keycutter::VERSION}.gem`
end

Before do
  @original_api_key  = Gem.configuration.rubygems_api_key
  @original_accounts = Gem.configuration.rubygems_accounts
end

After do
  Gem.configuration.rubygems_api_key  = @original_api_key
  Gem.configuration.rubygems_accounts = @original_accounts
end

at_exit do
  `gem uninstall keycutter -v #{Keycutter::VERSION}`
end
