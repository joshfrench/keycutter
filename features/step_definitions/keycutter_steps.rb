Given /^I have the following rubygems keys:$/ do |table|
  accounts = table.hashes.inject({}) do |hash,row|
    hash[row[:name]] = row[:key]
    hash
  end
  Gem.configuration.rubygems_accounts = accounts
end

Given /^my current rubygems key is "([^"]*)"$/ do |key|
  Gem.configuration.rubygems_api_key = Gem.configuration.rubygems_accounts[key]
end
