##
# Secure Only plugin on Padrino
#
#
SECURE_ONLY = "    app.use Rack::SecureOnly, :if => Padrino.env == :production"

require_dependencies 'rack-secure_only', :require => 'rack/secure_only'
initializer :secure_only, SECURE_ONLY