$:.unshift(File.dirname(__FILE__) + '/../../lib')

require 'fileutils'
require 'aruba/cucumber'
require 'cross-stub'
require 'keycutter'

xstub_cache = File.dirname(__FILE__) + '/../../xstub.cache'
test_credentials = File.dirname(__FILE__) + '/../../test_credentials'

AfterConfiguration do
  CrossStub.setup :file => xstub_cache
  Gem::ConfigFile.xstub(:credentials_path => test_credentials, :instance => true)
end

Before do
  CrossStub.refresh :file => xstub_cache
end

After do
  CrossStub.clear
end

at_exit do
  `gem uninstall keycutter -v #{Keycutter::VERSION}`
end
