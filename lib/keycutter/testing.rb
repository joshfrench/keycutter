require 'fakeweb'

FakeWeb.allow_net_connect = false
fakeweb_host = ENV['FAKEWEB_HOST'] || 'https://rubygems.org'
FakeWeb.register_uri :get, "#{fakeweb_host}/api/v1/api_key", {
                     :body => ENV['FAKEWEB_BODY'],
                     :status => [ENV['FAKEWEB_STATUS'], ENV['FAKEWEB_MESSAGE']]
                     }
