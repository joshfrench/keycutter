# encoding: utf-8
#
require 'bundler'
Bundler.setup
Bundler::GemHelper.install_tasks

require 'cucumber/rake/task'
Cucumber::Rake::Task.new do |t|
  t.cucumber_opts = %w{--format pretty}
end

task :default => :cucumber

require 'rspec/core/rake_task'
task :spec do
  RSpec::Core::RakeTask.new do |spec|
    spec.rspec_opts = %w{--color --format progress}
  end
end
