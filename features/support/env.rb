$:.unshift(File.dirname(__FILE__) + '/../../lib')

require 'aruba/cucumber'
require 'rspec/expectations'
require 'keycutter'

at_exit do
  `gem uninstall keycutter -v #{Keycutter::VERSION}`
end
