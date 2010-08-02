##
# Deflect Plugin via rack-contrib on Padrino
# prereqs:
# sudo gem install rack-contrib
# http://github.com/rack/rack-contrib/
# http://github.com/rack/rack-contrib/blob/master/lib/rack/contrib/deflect.rb
#
CONTRIB = <<-CONTRIB
    app.use Rack::Deflect,
      :log => $stdout,
      :request_threshold => 20,
      :interval => 2,
      :block_duration => 60
    #   :log                # When false logging will be bypassed, otherwise pass an object responding to #puts
    #   :log_format         # Alter the logging format
    #   :log_date_format    # Alter the logging date format
    #   :request_threshold  # Number of requests allowed within the set :interval. Defaults to 100
    #   :interval           # Duration in seconds until the request counter is reset. Defaults to 5
    #   :block_duration     # Duration in seconds that a remote address will be blocked. Defaults to 900 (15 minutes)
    #   :whitelist          # Array of remote addresses which bypass Deflect. NOTE: this does not block others
    #   :blacklist          # Array of remote addresses immediately considered malicious
CONTRIB
require_dependencies 'rack-contrib', :require => 'rack/contrib', :git => 'git://github.com/rack/rack-contrib.git'
initializer :deflect, CONTRIB