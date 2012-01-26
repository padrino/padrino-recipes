##
# Plugin to prepare Padrino app for deployent on www.dreamhost.com
# DH use old ruby and very old rack version!
#
# IMPORTANT !!!
# To bypass this problem, you DON'T use passanger in your host
# goto to DH panel control and uncheck
# Passenger (Ruby/Python apps only)
#
#

DISPATCH_FCGI = <<-DFCGI
#!/usr/bin/ruby
require 'rubygems'
require 'fcgi'

# DreamHost HACK !!!
# Set GEM_PATH and GEM_HOME ("USER_NAME" is your dreamhost user)
ENV['GEM_HOME'] ||= '/home/USER_NAME/.gems'
Gem.clear_paths

ENV['PADRINO_ENV'] ||= 'production'

require File.expand_path("../../config/boot.rb", __FILE__)

Rack::Handler::FastCGI.run(Padrino.application)
DFCGI

DOT_HTACCESS = <<-DHTX
<IfModule mod_fastcgi.c>
AddHandler fastcgi-script .fcgi
</IfModule>
<IfModule mod_fcgid.c>
AddHandler fcgid-script .fcgi
</IfModule>

Options +FollowSymLinks +ExecCGI

RewriteEngine On

RewriteCond %{REQUEST_FILENAME} !-f
RewriteRule ^(.*)$ dispatch.fcgi/$1 [QSA,L]

ErrorDocument 500 "Padrino  application failed to start properly"

DHTX

create_file destination_root('public/dispatch.fcgi'), DISPATCH_FCGI
create_file destination_root('public/.htaccess'), DOT_HTACCESS

unless File.read('Gemfile').include?('fcgi')
  inject_into_file destination_root('Gemfile'), "\n# DreamHost.com requirements\ngem 'fcgi'\n", :after => "source :rubygems\n"
end

require_dependencies 'fcgi'

shell.say ""
shell.say "Don't forget to adjust your USER_NAME with your dreamhost account into public/dispatch.fcgi"
shell.say "Don't forget to change file permission:"
shell.say "into your padrino root:"
shell.say "$ chmod 755 public"
shell.say "$ chmod 755 public/dispatch.fcgi"
shell.say ""
shell.say "IMPORTANT:"
shell.say "goto to DH panel control and uncheck"
shell.say "Passenger (Ruby/Python apps only)"
shell.say ""
shell.say "$ bundle install"
shell.say ""
shell.say "Check if it's work:"
shell.say "$ ruby public/dispatch.fcgi"
shell.say ""
