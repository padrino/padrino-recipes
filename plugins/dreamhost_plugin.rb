##
# Plugin to prepare Padrino app for deployent on www.dreamhost.com
# DH use old ruby and very old rack version!
#
# IMPORTANT !!!
# To bypass this problem, you DON'T use passanger in your host
# goto to DH panel control and uncheck
# Passenger (Ruby/Python apps only)
#
# TIPS :
#
# If you want to use ActiveRecord >= 3.2 (Padrino >= 0.10.6), you have to install a
# new version of rubygems on Dreamhost, since the one installed is too
# old (1.3.6) and therefore not compatible:
# read the wiki dhreamhost  or follow the following steps:
# $ cd ~ /
# $ mkdir. Gem bin lib src
# $ cd src
# $ wget http://production.cf.rubygems.org/rubygems/rubygems-1.8.15.tgz  (latest version at this time)
# $ tar xvf rubygems-1.8.15.tgz
# $ cd rubygems-1.8.15
# $ ruby setup.rb - prefix = $ HOME
# $ cd ~ / bin
# $ ln-s gem1.8 gem
# Add the following lines. Bash_profile
# $ export PATH = "$ HOME / bin: $ HOME / .gems / bin: $ PATH"
# $ export RUBYLIB = "$ HOME / lib: $ RUBYLIB"
# then
# $ source ~ /. Bash_profile
# $ which gem # Should return / home / USERNAME / bin / gem
# $ gem-v # Should return 1.8.15
# DH wiki: http://wiki.dreamhost.com/RubyGems

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
