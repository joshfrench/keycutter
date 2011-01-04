Given /^I have the following api keys:$/ do |table|
  keys = table.hashes.inject({}) do |hash,row|
    hash[row[:name]] = row[:key]
    hash
  end
  Gem.configuration.api_keys = keys
end

Given /^my current rubygems key is "([^"]*)"$/ do |key|
  Gem.configuration.rubygems_api_key = Gem.configuration.api_keys[key]
end

Given /^a valid gemcutter account$/ do
  set_env 'FAKEWEB_BODY', '3'*32
  set_env 'FAKEWEB_STATUS', '200'
  set_env 'FAKEWEB_MESSAGE', 'OK'
end

Given /^an invalid gemcutter account$/ do
  set_env 'FAKEWEB_BODY', 'HTTP Basic: Access denied.'
  set_env 'FAKEWEB_STATUS', '401'
  set_env 'FAKEWEB_MESSAGE', 'Unauthorized'
end

Then /^my current rubygems key should be "([^"]*)"$/ do |key|
  Gem.configuration.load_rubygems_api_key
  Gem.configuration.rubygems_api_key.should == Gem.configuration.api_keys[key]
end

Then /^I should have a "([^"]*)" api key$/ do |key|
  Gem.configuration.load_api_keys
  Gem.configuration.api_keys.should have_key(key)
end

Then /^I should not have a "([^"]*)" api key$/ do |key|
  Gem.configuration.load_api_keys
  Gem.configuration.api_keys.should_not have_key(key)
end

Then /^the "([^"]*)" api key should be the response body$/ do |key|
  Gem.configuration.load_api_keys
  Gem.configuration.api_keys[key].should == ENV['FAKEWEB_BODY']
end
