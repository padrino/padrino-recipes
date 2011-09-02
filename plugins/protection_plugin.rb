##
# Template to get rack-protection on Padrino
# prereqs:
#
# http://github.com/rkh/rack-protection
#
PROTECTION = <<-PROT
    app.use Rack::Protection
    # :except => :path_traversal # set this to skip a single protection middleware
PROT
require_dependencies 'rack-protection', :require => 'rack/protection'
initializer :protection, PROTECTION
