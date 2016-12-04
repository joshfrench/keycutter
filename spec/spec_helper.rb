$:.unshift(File.dirname(__FILE__) + '/../../lib')

require 'rspec/mocks'
require 'keycutter'

# Set permissions to what rubygems wants,
# so it doesn't throw a permissions error
File.chmod(0600, 'test_credentials')
