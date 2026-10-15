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
# The notifier renders exceptions_page for every 404 and 500, so give it one.
settings = "    set :exceptions_page, :errors\n"
# It wraps the page in layouts/application, which new apps don't have yet.
settings += "    set :exceptions_layout, false\n" if Dir[destination_root('app/views/layouts/application.*')].empty?
inject_into_file destination_root('app/app.rb'), settings, :after => "register Padrino::Contrib::ExceptionNotifier\n"
errors_page = {
  'haml' => "%h1= response.status\n",
  'slim' => "h1 = response.status\n",
  'erb'  => "<h1><%= response.status %></h1>\n"
}
renderer = fetch_component_choice(:renderer).to_s
renderer = 'erb' unless errors_page.key?(renderer)
create_file destination_root("app/views/errors.#{renderer}"), errors_page[renderer]
