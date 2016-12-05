Given /^I have the following api keys:$/ do |table|
  keys = table.hashes.inject({}) do |hash,row|
    hash[row[:name].to_sym] = row[:key]
    hash
  end
  Gem.configuration.api_keys = keys
end

Given /^my current rubygems key is "([^"]*)"$/ do |key|
  Gem.configuration.rubygems_api_key = Gem.configuration.api_keys[key.to_sym]
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

Given /^a gemcutter host at "([^"]*)"$/ do |host|
  set_env 'FAKEWEB_HOST', host
end

Then /^my current rubygems key should be "([^"]*)"$/ do |key|
  Gem.configuration.load_api_keys
  expect(Gem.configuration.rubygems_api_key).to eq(Gem.configuration.api_keys[key.to_sym])
end

Then /^I should have a "([^"]*)" api key$/ do |key|
  Gem.configuration.load_api_keys
  expect(Gem.configuration.api_keys).to have_key(key.to_sym)
end

Then /^I should not have a "([^"]*)" api key$/ do |key|
  Gem.configuration.load_api_keys
  expect(Gem.configuration.api_keys).not_to have_key(key.to_sym)
end

Then /^the "([^"]*)" api key should be the response body$/ do |key|
  Gem.configuration.load_api_keys
  expect(Gem.configuration.api_keys[key.to_sym]).to eq(ENV['FAKEWEB_BODY'])
end
