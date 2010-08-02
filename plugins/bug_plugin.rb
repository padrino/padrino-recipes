##
# Template to get rack-bug on Padrino
# prereqs:
# sudo gem install rack-bug
# http://github.com/brynary/rack-bug
#
BUG = <<-BUG
    app.use Rack::Bug,
      :secret_key => "someverylongandveryhardtoguesspreferablyrandomstring"
    # extra configurations
    # :password => 'password',
    # :ip_masks   => [IPAddr.new("2.2.2.2/0")],
    # :panel_classes => [
    #     Rack::Bug::TimerPanel,
    #     Rack::Bug::RequestVariablesPanel,
    #     Rack::Bug::RedisPanel,
    #     Rack::Bug::TemplatesPanel,
    #     Rack::Bug::LogPanel,
    #     Rack::Bug::MemoryPanel
    #   ]

BUG
require_dependencies 'rack-bug', :require => 'rack/bug'
initializer :bug, BUG