Given /^I have installed keycutter$/ do
  `rake build`
  `gem install pkg/keycutter-#{Keycutter::VERSION}.gem`
end

