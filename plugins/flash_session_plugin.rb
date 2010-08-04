##
# FlashMiddleware help you passing your session in the URI, when it should be in the cookie.
#
# This code it's only performed when:
#
#   env['HTTP_USER_AGENT'] =~ /^(Adobe|Shockwave) Flash/
#
# ==== Usage
#
#  use FlashMiddleware, session_id
#
# prereqs:
# sudo gem install padrino-contrib
#
require_contrib('flash_session')
initializer("Padrino::Contrib::FlashSession")
inject_into_file "app/app.rb", "  # use FlashSessionMiddleware, session_id\n", :after => "Padrino::Contrib::FlashSession\n"