Before '@fakeweb' do
  require 'drb'
  set_env 'FAKEWEB', 'test'
end

After '@fakeweb' do
  DRb.stop_service
end
