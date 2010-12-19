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

Given /^a valid gemcutter account$/ do
  @response = {:body => '3'*32}
  DRb.start_service "druby://localhost:3333", [:get, "https://rubygems.org/api/v1/api_key", @response]
end

Given /^an invalid gemcutter account$/ do
  @response = {:body => "HTTP Basic: Access denied", :status => ["401", "Not Authorized"]}
  DRb.start_service "druby://localhost:3333", [:get, "https://rubygems.org/api/v1/api_key", @response]
end

Then /^my current rubygems key should be "([^"]*)"$/ do |key|
  Gem.configuration.load_rubygems_api_key
  Gem.configuration.rubygems_api_key.should == Gem.configuration.rubygems_accounts[key]
end

Then /^I should have a "([^"]*)" rubygems key$/ do |key|
  Gem.configuration.load_rubygems_accounts
  Gem.configuration.rubygems_accounts.should have_key(key)
end

Then /^I should not have a "([^"]*)" rubygems key$/ do |key|
  Gem.configuration.load_rubygems_accounts
  Gem.configuration.rubygems_accounts.should_not have_key(key)
end

Then /^the "([^"]*)" rubygems key should be the response body$/ do |key|
  Gem.configuration.load_rubygems_accounts
  Gem.configuration.rubygems_accounts[key].should == @response[:body]
end
