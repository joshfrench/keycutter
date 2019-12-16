# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "keycutter/version"

Gem::Specification.new do |s|
  s.name        = "keycutter"
  s.version     = Keycutter::VERSION
  s.platform    = Gem::Platform::RUBY
  s.licenses    = ['MIT']
  s.authors     = ["Josh French"]
  s.email       = ["josh@vitamin-j.com"]
  s.homepage    = "http://github.com/joshfrench/keycutter"
  s.summary     = %q{Gemcutter key management}
  s.description = %q{Multiple gemcutter accounts? Manage your keys with ease.}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {spec,features}/*`.split("\n")
  s.require_paths = ["lib"]
end
