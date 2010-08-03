##
# Template to get GoogleAnalytics on Padrino
# prereqs:
# sudo gem install rack-google-analytics
# http://github.com/leehambley/rack-google-analytics
#
ANALYTICS = <<-ANALYTICS
    app.use Rack::GoogleAnalytics, :tracker => 'UA-xxxxxx-x'
ANALYTICS
require_dependencies 'rack-google-analytics'
initializer :analytics, ANALYTICS