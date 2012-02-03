##
# A Plugin to prepare a Padrino app for deployment to www.dreamhost.com
# Dreamhost uses an earlier Ruby version (1.8.7) and very old rack version (1.3.6)!
#
# IMPORTANT !!!
# To bypass this problem, you SHOULD NOT use Passenger as your rack server.
# Disable it by going to the Dreamhost control panel and unchecking
# 'Passenger (Ruby/Python apps only)'
#
# TIPS :
#
# If you wish to use ActiveRecord >= 3.2 (Padrino >= 0.10.6) you first have to 
# install a new version of rubygems on your Dreamhost server because the existing one 
# already installed is so  old (1.3.6) it is incompatible:
# read the wiki Dreamhost or follow these steps:
# $ cd ~/
# $ mkdir. Gem bin lib src
# $ cd src
# $ wget http://production.cf.rubygems.org/rubygems/rubygems-1.8.15.tgz  (the latest version at the present time)
# $ tar xvf rubygems-1.8.15.tgz
# $ cd rubygems-1.8.15
# $ ruby setup.rb - prefix = $HOME
# $ cd ~/bin
# $ ln-s gem1.8 gem
# Add the following lines in the  ~/.bash_profile
# $ export PATH = "$HOME/bin:$HOME/.gems/bin:$PATH"
# $ export RUBYLIB = "$HOME/lib:$RUBYLIB"
# then
# $ source ~/.Bash_profile
# $ which gem # Should return /home/USERNAME/bin/gem
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

ErrorDocument 500 "Padrino application failed to start properly"

DHTX

create_file destination_root('public/dispatch.fcgi'), DISPATCH_FCGI
create_file destination_root('public/.htaccess'), DOT_HTACCESS

unless File.read('Gemfile').include?('fcgi')
  inject_into_file destination_root('Gemfile'), "\n# DreamHost.com requirements\ngem 'fcgi'\n", :after => "source :rubygems\n"
end

require_dependencies 'fcgi'

shell.say ""
shell.say "Don't forget to swap USER_NAME for you Dreamhost account name in public/dispatch.fcgi"
shell.say "Don't forget to change these file permissions:"
shell.say "$ chmod 755 public"
shell.say "$ chmod 755 public/dispatch.fcgi"
shell.say ""
shell.say "IMPORTANT:"
shell.say "Go to the Dreamhost control panel and uncheck"
shell.say "Passenger (Ruby/Python apps only)"
shell.say ""
shell.say "Run bundler"
shell.say "$ bundle install"
shell.say ""
shell.say "Finally check to see if your site is working:"
shell.say "$ ruby public/dispatch.fcgi"
shell.say ""
