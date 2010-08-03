# We generate a basic project
say
project :test => :none, :renderer => :haml, :script => :jquery, :orm => :activerecord, :dev => yes?("Are you using padrino-dev?").present?, :tiny => yes?("Do you need a tiny structure?").present?, :bundle => true, :adapter => ask("SQL adapter for ActiveRecord (sqlite, mysql, postgres):")

say "=> Installing exception notifier", :magenta
execute_runner :plugin, :exception_notifier

say
exception_subject = ask("Tell me the subject of the exception email", fetch_project_name)
exception_from    = ask("Tell me the sender of the email", "exceptions@lipsiasoft.com")
exception_to      = ask("Tell me the recipient email", "help@lipsiasoft.com")

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

say
if yes?("Do you want configure exception notifier for redmine?")
  redmine_project  = ask("Tell me the redmine project", "lipsiabug")
  redmine_tracker  = ask("Tell me the redmine tracker", "bug")
  redmine_assigned = ask("Tell me what account we assign the issue", "s.crespi")
  exception_tpl += "\n  set :redmine, { :project => \"#{redmine_project}\", :tracker => \"#{redmine_tracker}\", :assigned => \"#{redmine_assigned}\" }"
end

exception_tpl += "\n"

inject_into_file "app/app.rb", exception_tpl, :after => "Padrino::Application\n"

say
if yes?("Would you like to generate the padrino admin?")
  generate :admin
  inject_into_file "admin/app.rb", exception_tpl, :after => "Padrino::Application\n"
end

say
if yes?("Do you want install carrierwave?")
  execute_runner :plugin, :carrierwave
end

say
if yes?("Would you like to generate the basic frontend?")
  execute_runner :plugin, "960"

  helpers_tpl = <<-RUBY
  def key_density(*words)
    words.compact.join(" ").concat(" - Padrino Ruby Web Framework").gsub(/^ - /, '')
  end

  def title(*words)
    @_title = key_density(*words) if words.present?
    @_title
  end

  def description(text=nil)
    @_description = truncate(text.gsub(/<\\/?[^>]*>/, '').gsub(/\\n/, ' ').strip, :length => 355) if text.present?
    @_description || (<<-TXT).gsub(/ {6}/, '').gsub(/\\n/, ' ').strip
      Padrino is a ruby framework built upon the excellent Sinatra Microframework.
      This framework tries hard to make it as fun and easy as possible to code much more advanced web
      applications by building upon the Sinatra philosophies and foundation.
    TXT
  end
  RUBY

  route_tpl = <<-RUBY
  get "/" do
    render :index
  end
  RUBY

  create_file "public/stylesheets/base.css", "http://github.com/padrino/padrino-recipes/raw/master/files/lipsiasoft/base.css"

  if tiny?
    get "http://github.com/padrino/padrino-recipes/raw/master/files/lipsiasoft/errors.haml", "app/views/errors.haml"
    get "http://github.com/padrino/padrino-recipes/raw/master/files/lipsiasoft/layout.haml", "app/views/layout.haml"
    get "http://github.com/padrino/padrino-recipes/raw/master/files/lipsiasoft/index.haml", "app/views/index.haml"
    inject_into_file "app/helpers.rb", helpers_tpl, :after => "helpers do\n"
    inject_into_file "app/controllers.rb", route_tpl, :after => "controllers  do\n"
  else
    get "http://github.com/padrino/padrino-recipes/raw/master/files/lipsiasoft/errors.haml", "app/views/base/errors.haml"
    get "http://github.com/padrino/padrino-recipes/raw/master/files/lipsiasoft/layout.haml", "app/views/layouts/application.haml"
    generate :controller, "base"
    get "http://github.com/padrino/padrino-recipes/raw/master/files/lipsiasoft/index.haml", "app/views/base/index.haml"
    inject_into_file "app/controllers/base.rb", route_tpl, :after => "controllers :base do\n"
    create_file "app/helpers/base.rb", "#{fetch_app_name("/app")}.helpers do\n#{helpers_tpl}\nend"
  end
end

say
if yes?("Your database connection is correct (if yes we run migrations and seeds)?")
  rake "ar:create ar:migrate seed"
end