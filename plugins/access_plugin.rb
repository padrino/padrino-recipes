##
# Access Plugin via rack-contrib on Padrino
# prereqs:
# sudo gem install rack-contrib
# http://github.com/rack/rack-contrib/
# http://github.com/rack/rack-contrib/blob/master/lib/rack/contrib/access.rb
#
CONTRIB = <<-CONTRIB
    app.use Rack::Access, '/backend' => ['127.0.0.1', '192.168.1.0/24']
CONTRIB
require_dependencies 'rack-contrib', :require => 'rack/contrib', :git => 'git://github.com/rack/rack-contrib.git'
initializer :access, CONTRIB