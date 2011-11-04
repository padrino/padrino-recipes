##
# Authentication Plugin via omniauth on Padrino
# prereqs:
# http://github.com/intridea/omniauth/
# http://github.com/achiu/omniauth/ working fork
#
OMNIAUTH = <<-OMNIAUTH
    app.use OmniAuth::Builder do
      provider :developer unless Padrino.env == :production
      # provider :twitter, 'consumer_key', 'consumer_secret'
      # provider :facebook, 'app_id', 'app_secret'
    end
OMNIAUTH
require_dependencies 'omniauth'
initializer :omniauth, OMNIAUTH
