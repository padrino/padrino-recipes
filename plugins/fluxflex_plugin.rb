##
# Plugin to prepare Padrino app for deployent on on www.fluxflex.org
#  prereqs: fcgi ("$ gem install fcgi" or "gem 'fcgi'" in your Gemfile)
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
# == Required files
#
# === .flx file
# 
# Is an intializer script. Should be in root of your project. Contains commands
# you want to run during different stages of your deployemnt. Read more about
# it at
# http://doc.fluxflex.com/deployment-initialization-script/about-initializer-script
# Note: since this script is in your github repo, you may want to use
# environment variables for sensitive information,such as passwords etc.
# You can set your environment variables through fluxflex.com web interface.
#
# === 

# This sets up ruby environment, which is fluxflex.com specific
# You have a choice of ruby1.8.7 or ruby1.9.2

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

DOT_FLX = <<-DFLX
[setup]
ln -s public public_html
chmod 705 public/dispatch.fcgi
bash fluxflex_deploy.sh

[replace]
public/dispatch.fcgi USER_NAME PROJECT_NAME

[deploy]
chmod 705 public/dispatch.fcgi
bash fluxflex_deploy.sh

DFLX

FLUXFLEX_DEPLOY = <<-FLXD

FLXD

# This script is run when you first put file on the server
# (It can be run again any time by using fluxflex web interface)
# A good place to put your rake db migration task
FLUXFLEX_SETUP = <<FLXS
#{ruby_export}
# put your db:migration:reset rake test here
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

DB_VARS = <<-DB
  Database environment vars
DB

inject_into_file destination_root('Gemfile'), "\n#fluxflex.com requirements\ngem 'fcgi'\n", :after => "source :rubygems\n"
inject_into_file destination_root('config/database.rb'), DB_VARS, :before => "case Padrino.env"

require_dependencies 'fcgi'
