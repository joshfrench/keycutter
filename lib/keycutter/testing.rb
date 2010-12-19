require 'drb'
require 'fakeweb'

DRb.start_service
remote = DRbObject.new(nil, "druby://localhost:3333")

FakeWeb.allow_net_connect = false
FakeWeb.register_uri *remote
