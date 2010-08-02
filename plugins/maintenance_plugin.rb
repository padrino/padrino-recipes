##
# Maintanence plugin on Padrino
# prereqs:
# sudo gem install rack-maintenance
# http://github.com/ddollar/rack-maintenance
#
MAINT = <<-MAINT
    app.use Rack::Maintenance,
       :file => Padrino.root('public/maintenance.html')
       # :env  => 'MAINTENANCE'
MAINT
PAGE = <<-PAGE
<html>
<head><title>Site Under Maintenance</title></head>
<body><h1> This Site is Currently Under Maintenance!</h1>
</html>
PAGE
require_dependencies 'rack-maintenance', :require => 'rack/maintenance'
initializer :maintenance, MAINT
create_file destination_root('public/maintenance.html'), PAGE