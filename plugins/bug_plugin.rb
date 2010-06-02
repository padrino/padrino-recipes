# Template to get rack-bug on Padrino
# prereqs:
# sudo gem install rack-bug
# http://github.com/brynary/rack-bug
BUG = <<-BUG
    app.use Rack::Bug,
      :secret_key => "someverylongandveryhardtoguesspreferablyrandomstring"
BUG
require_dependencies 'rack-bug', :require => 'rack/bug'
initializer :bug,BUG