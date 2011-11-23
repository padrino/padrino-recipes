##
# Plugin to prepare Padrino app for deployent on on www.fluxflex.org
#  prereqs:
#  - fcgi ("$ gem install fcgi" or "gem 'fcgi'" in your Gemfile)
#  - git (to deploy via 'git push')
# 
# == INTRO
#
# FluxFlex.com is Platform as a Service (PaaS), similar to Heroku.
# You can deploy applications through simple 'git push' and manage it through
# simple web interface. You can also have custom domain names for your apps.
#
# When you 'git push' your app to fluxflex.com, it runs several initialization
# scripts, that install your gems, set up ruby environment etc.
#
# This plugin contains minimal config scripts to 'fluxflexify' your padrino
# app.
# 
# == REQUIRED FILES
#
# === .flx file
# 
# This is an intializer script. Should be in root of your project. Contains commands
# you want to run during different stages of your deployemnt.
# [deploy] commands are executed after each 'git push' to the server
# [setup] commands are executed when you do the first 'git push', so you may
# want to execute your database migration rake tasks here. You can later re-run
# the setup commands through fluxflex web interface.
# 
# Note: since .flx script is checked in into your repo, you may want to use
# environment variables for sensitive information,such as passwords etc.
# Read more about it at : http://doc.fluxflex.com
#
# === public_html directory
#  it has to exist, so we simlink /public to it.
# 
# === public_html/dispatch.fcgi file
# 
# Because fluxflex uses fcgi with apache, this file is used to load
# Padrino libraries and to run Padrino.application in place of 'config.ru'
#
# === public_html/.htaccess file
# redirects all requests to dispatch.fcgi (apache specific)
#
# === flx_deploy.sh file
# installs rubygems (on each 'git push')
# 
# === flx_setup.sh file (optional)
# install rubygems, runs db migrations
#
# EXAMPLE: HOW TO PUT EXISTING PADRINO APP ON FLUXFLEX.COM
#
# 1. Register at www.fluxflex.com, go to dashboard and create a project,
# such as 'myapp'.
#
# 2. Go to project menu: Setup / Git and copy url string for your
# remote git repo (something like ssh://git@git.fluxflex.com:443/myapp)
# 
# 3. cd to local padrino app directory (should be under git control)
# and add your fluxflex repo as a remote called 'ff', then pull from it.
# 
#   $ git remote add ff ssh://git@git.fluxflex.com:443/myapp
#   $ git pull ff master
#
# 4. Now, *remove public_html* directory and run this fluxflex plugin:
#
#   $ bundle exec padrino g plugin <path to this plugin>
#
# 5. Finally, commit files created by this plugin to your local repo and do:
#
#   $ git push ff master
#
# 6. You may need to manually setup the project by pressing 'Deploy'
# button in your fluxflex web interface, and ticking "Request to clear repository and setup" checkbox in the resulting dialog.
#
# Now you should see your app running at http://myapp.fluxfle.com
#
# DATABASE USE
#
# Replace database name, password user etc. in your production database
# configuration string (in your 'database.rb' file) with below variables.
# Your connection string should look like this:
#
#   "mysql2://FLX_DB_USER:FLX_DB_PASS@FLX_DB_HOST/FLX_DB_NAME"
#
# You can see your MySQL connection information through fluxflex.com web
# interface and manage your database through phpMyAdmin.
#
# DATABASE MIGRATIONS
#
# depending on your orm, place appropriate rake db:migration:reset command
# in your fluxfles_setup.sh file.
# 

RUBY_INIT_1_9 = <<-RI9
#!/usr/bin/env /usr/local/rvm/rubies/ruby-1.9.2-p180/bin/ruby

__user_home   = "/home/USER_NAME"

ENV['GEM_HOME'] = __user_home + "/.gem/ruby/1.9.1/"
ENV['GEM_PATH'] = ENV['GEM_HOME']

RI9

RUBY_EXPORT_1_9 = <<-RE9
export GEM_HOME=$HOME/.gem/ruby/1.9.1/
export GEM_PATH=$GEM_HOME
export PATH=$PATH:/usr/local/rvm/rubies/ruby-1.9.2-p180/bin:$HOME/.gem/ruby/1.9.1/bin
RE9

RUBY_INIT_1_8 = <<-RI8
#!/usr/bin/env /usr/local/rvm/rubies/ruby-1.8.7-p334/bin/ruby

__user_home   = "/home/USER_NAME"

ENV['GEM_HOME'] = __user_home + "/.gem/ruby/1.8"
ENV['GEM_PATH'] = ENV['GEM_HOME']

RI8

RUBY_EXPORT_1_8 = <<-RE8
export GEM_HOME=$HOME/.gem/ruby/1.8
export GEM_PATH=$GEM_HOME
export PATH=$PATH:/usr/local/rvm/rubies/ruby-1.8.7-p334/bin:$HOME/.gem/ruby/1.8/bin
RE8

ruby_init = RUBY_VERSION.include?("1.8") ? RUBY_INIT_1_8 : RUBY_INIT_1_9
ruby_export = RUBY_VERSION.include?("1.8") ? RUBY_EXPORT_1_8 : RUBY_EXPORT_1_9

DB_VARS = <<-DBV
config/database.rb FLX_DB_NAME PROJECT_NAME
config/database.rb FLX_DB_HOST DB_HOST
config/database.rb FLX_DB_USER DB_USER
config/database.rb FLX_DB_PASS DB_PASSWORD
DBV

DOT_FLX = <<-DFLX
[replace]
public/dispatch.fcgi USER_NAME PROJECT_NAME
#{FileTest.exists?('config/database.rb') ? DB_VARS : ''}

[setup]
ln -s public public_html
chmod 705 public/dispatch.fcgi
bash fluxflex_setup.sh

[deploy]
chmod 705 public/dispatch.fcgi
bash fluxflex_deploy.sh

DFLX

FLUXFLEX_DEPLOY = <<-FLXD
#{ruby_export}
gem install bundler --no-ri --no-rdoc

bundle install --without development test
FLXD

FLUXFLEX_SETUP = <<FLXS
#{ruby_export}
# 
# put your db:migration:reset rake task here
# Example for sequel:
# 
# gem install bundler --no-ri --no-rdoc
# bundle install --without development test
# PADRINO_ENV=production bundle exec padrino rake sq:migrate:auto 
#
# You also need to use the following db connections string in your
# database.rb (sequel example, adjust for your adapter):
# /.../
# when :production\
# then Sequel.connect(\
# "mysql2://FLX_DB_USER:FLX_DB_PASS@FLX_DB_HOST/FLX_DB_NAME",
#   :loggers => [logger] ) /.../ etc.


FLXS

DISPATCH_FCGI = <<-DFCGI
#{ruby_init}

ENV['PADRINO_ENV'] ||= 'production'

require File.expand_path("../../config/boot.rb", __FILE__)

Rack::Handler::FastCGI.run Padrino.application
DFCGI

DOT_HTACCESS = <<-DHTX
RewriteEngine On
RewriteBase /

DirectoryIndex dispatch.fcgi

RewriteCond %{REQUEST_FILENAME} !-f
RewriteCond %{REQUEST_FILENAME} !-d
RewriteRule ^(.*)$ dispatch.fcgi/$1 [L]

DHTX

create_file destination_root('.flx'), DOT_FLX
create_file destination_root('fluxflex_deploy.sh'), FLUXFLEX_DEPLOY
create_file destination_root('fluxflex_setup.sh'), FLUXFLEX_SETUP
create_file destination_root('public/dispatch.fcgi'), DISPATCH_FCGI
create_file destination_root('public/.htaccess'), DOT_HTACCESS

unless File.read('Gemfile').include?('fcgi')
  inject_into_file destination_root('Gemfile'), "\n# fluxflex.com requirements\ngem 'fcgi'\n", :after => "source :rubygems\n"  
end

require_dependencies 'fcgi'

shell.say ""
shell.say "Don't forget to adjust your db connection string"
shell.say "to look like this (adjust for your adapter):"
shell.say "mysql2://FLX_DB_USER:FLX_DB_PASS@FLX_DB_HOST/FLX_DB_NAME"
shell.say ""


