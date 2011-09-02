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

CMPASS = <<-CMPS
    Sass::Plugin.options[:never_update] = true if Padrino.env == :production

CMPS

orm = fetch_component_choice(:orm)
css = fetch_component_choice(:stylesheet)

adapter = case orm
  when 'activerecord' then 'pg'
  when 'datamapper'   then 'dm-postgres-adapter'
end

append_file("Gemfile", "\n# Heroku\ngem '#{adapter}', :group => :production") if adapter

case orm
  when 'datamapper', 'sequel'
    gsub_file "config/database.rb", /\"sqlite.*production.*/, "ENV['DATABASE_URL'])"
  when 'activerecord'
    gsub_file "config/database.rb", /^.+production.*\{(\n\s+\:.*){2}\n\s\}/, AR_CONFIG
  else
    say "Remember to configure your production database, if necessary.", :yellow
end

if css == 'compass'
  inject_into_file destination_root('lib/compass_plugin.rb'), CMPASS, :before => "    Compass.configure_sass_plugin!"
end

if (val = css.match(/scss|sass/))
  inject_into_file destination_root("lib/#{val[0]}_init.rb"), CMPASS.gsub(/^    /,''), :before => "app.use Sass::Plugin::Rack"
end
