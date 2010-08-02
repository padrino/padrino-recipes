# We generate a basic project
project :test => :none, :renderer => :haml, :script => :jquery, :orm => :activerecord, :tiny => yes?("Do you need a tiny structure?")

say "Installing exception notifier", :green
execute_runner :plugin, :exception_notifier
exception_subject = ask("Tell me the subject of the exception email, if you use redmine could be only #{fetch_project_name}")
exception_from    = ask("Tell me the sender of the email i.e. exceptions@lipsiasoft.com")
exception_to      = ask("Tell me the recipient email i.e. help@lipsiasoft.com")

exception_tpl = <<-RUBY
##
# Exception Notifier
#
register ExceptionNotifier
set :exceptions_subject, "#{fetch_project_name}"
set :exceptions_from,    "#{exception_from}"
set :exceptions_to,      "#{exception_to}"
set :exceptions_page,    "#{'base/' if tiny?}errors"
RUBY

if yes?("Do you want configure exception notifier for redmine?")
  redmine_project  = ask("Tell me the redmine project i.e. lipsiabug")
  redmine_tracker  = ask("Tell me the redmine tracker i.e. bug")
  redmine_assigned = ask("Tell me what account we assign the issue i.e. d.dagostino")
  exception_tpl += "\nset :redmine, { :project => \"#{redmine_project}\", :tracker => \"#{redmine_tracker}\", :assigned => \"#{redmine_assigned}\" }"
end

inject_into_file "app/app.rb", exception_tpl, :after => "Padrino::Application\n"

if yes?("Would you like to generate the padrino admin?")
  generate :admin
  rake "ar:create ar:migrate seed"
  inject_into_file "admin/app.rb", exception_tpl, :after => "Padrino::Application\n"
end

if yes?("Do you want install carrierwave?")
  execute_runner :carrierwave
end

if yes?("Would you like to generate the basic frontend?")
  execute_runner :plugin, "960"
  if tiny?
    get "http://github.com/padrino/padrino-recipes/raw/master/files/lipsiasoft/errors.haml", "app/views/errors.haml"
    get "http://github.com/padrino/padrino-recipes/raw/master/files/lipsiasoft/layout.haml", "app/views/layout.haml"
  else
    get "http://github.com/padrino/padrino-recipes/raw/master/files/lipsiasoft/errors.haml", "app/views/base/errors.haml"
    get "http://github.com/padrino/padrino-recipes/raw/master/files/lipsiasoft/layout.haml", "app/views/layouts/application.haml"
  end
end