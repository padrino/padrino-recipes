##
# This is an exception notifier for Padrino::Application with
# redmine bonus feature.
#
# ==== Usage
#
#   class MyApp < Padrino::Application
#     register Padrino::Contrib::ExceptionNotifier
#     set :exceptions_from,    "errors@localhost.local"
#     set :exceptions_to,      "foo@bar.local"
#     set :exceptions_page,    :errors # => views/errors.haml/erb
#     set :redmine, :project => "My Bugs", :tracker => "Bugs", :priority => "High"
#     # Uncomment this for test in development
#     #  disable :raise_errors
#     #  disable :show_exceptions
#   end
#
# prereqs:
# sudo gem padrino-contrib
#
require_contrib('exception_notifier')
initializer("Padrino::Contrib::ExceptionNotifier")