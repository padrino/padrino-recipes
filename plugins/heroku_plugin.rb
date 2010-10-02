##
# Prepare app for deployment to Heroku by configuring production database,
# adding required gem dependencies and adding a Rakefile with Padrino tasks.
#
# Based on information from http://www.padrinorb.com/guides/blog-tutorial

RAKEFILE = <<-RAKEFILE
require File.dirname(__FILE__) + '/config/boot.rb'
require 'thor'
require 'padrino-core/cli/rake'

PadrinoTasks.init
RAKEFILE

create_file "Rakefile", RAKEFILE

AR_CONFIG = <<-AR_CONFIG
postgres = URI.parse(ENV['DATABASE_URL'] || '')
ActiveRecord::Base.configurations[:production] = {
  :adapter  => 'postgresql',
  :encoding => 'utf8',
  :database => postgres.user,
  :username => postgres.user,
  :password => postgres.password,
  :host     => postgres.host
}
AR_CONFIG

orm = fetch_component_choice(:orm)

case orm
  when 'datamapper'
    gsub_file "config/database.rb", /\"sqlite3.*production.+/, "ENV['DATABASE_URL'])"
    append_file "Gemfile", "\n# Heroku\ngem 'dm-postgres-adapter', :group => :production"
  when 'activerecord'
    gsub_file "config/database.rb", /^.+production.*\{(\n\s+\:.*){2}\n\s\}/, AR_CONFIG
    append_file "Gemfile", "\n# Heroku\ngem 'pg', :group => :production"
  else
    say "Remember to configure your production database, if necessary.", :yellow
end