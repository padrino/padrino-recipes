##
# A Plugin to prepare a Padrino app for deployment to www.dreamhost.com
# With this version of plugin, you now use any version of ruby (mri)
# into your dreamhost shared hosting (yes you now use also ruby 1.9.x !! yeahhh)
#
# IMPORTANT !!!
#
# To use a different ruby version, you need to install rbenv into your shell account
# (i've' tested only rbenv, sorry)
#
# HOW TO INSTALL RBENV:
#
# full code: http://git.io/jLwG7g
#
# THANKS TO @micahchalmer !!!!
# Initial setup for Ruby 1.9.3 on DreamHost shared hosting.
# We assume you're already in your project's root directory, which should
# also be the directory configured as "web directory" for your domain
# in the DreamHost panel.
#
#
# Install rbenv and ruby-build
# $ git clone git://github.com/sstephenson/rbenv.git ~/.rbenv
# $ git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
#
# Create temporary directory--DreamHost does not allow files in /tmp to be
# executed, which makes the default not work
# $ mkdir ~/.rbenv/BUILD_TEMP
#
# DreamHost will set your GEM_HOME and GEM_PATH for you, but this conflicts
# with rbenv, so we unset them here.  You'll want to do this in your .bashrc
# on the dreamhost account.
# $ unset GEM_HOME
# $ unset GEM_PATH
#
# Add rbenv to PATH and let it set itself up.
# You probably want these two lines in your .bashrc as well:
# $ export PATH=~/.rbenv/bin:"$PATH"
# $ eval "$(~/.rbenv/bin/rbenv init -)"
#
# Decide which version of Ruby we're going to install and use.
# $ NEW_RUBY_VERSION=1.9.3-p385
#
# Using that as the temp space, build and install ruby 1.9.3
# $ TMPDIR=~/.rbenv/BUILD_TEMP rbenv install $NEW_RUBY_VERSION
#
# Now everything is set up properly, you should be able to set your
# directory to use the new ruby:
# $ rbenv local $NEW_RUBY_VERSION
#
# Bundler doesn't come with ruby, so install it first:
# $ gem install bundler
#
# Then use it to install the rest of your gems:
# $ bundle install
#
# Change value of use_rbenv to true into dispatch.fcgi
#
# Don't forget to make your dispatch.fcgi world-executable but not world-writable by executing
# replace PADRINO_ROOT with real path of application
# $ chmod 755 PADRINO_ROOT/public/dispatch.fcgi

DISPATCH_FCGI = <<-DFCGI
#!/bin/bash
use_rbenv=false
padrino_dir=`pwd`
padrino_dir=${padrino_dir/public/}
err_log_file="${padrino_dir}/log/dispatch_err.log"

if $use_rbenv ; then
  unset GEM_HOME
  unset GEM_PATH
  export PATH=~/.rbenv/bin:"$PATH"
  eval "$(~/.rbenv/bin/rbenv init -)"
  exec ~/.rbenv/shims/ruby "${padrino_dir}public/dispatch_fcgi.rb" "$@" 2>>"${err_log_file}"
else
  padrino_dir=`pwd`
  err_log_file="${padrino_dir}/log/dispatch_err.log"
  export GEM_HOME=~/.gems
  export GEM_PATH="$GEM_HOME:/usr/lib/ruby/gems/1.8"
  export PATH="$GEM_HOME/bin:$PATH"
  exec ruby "${padrino_dir}/dispatch_fcgi.rb" "$@" 2>>"${err_log_file}"
fi
DFCGI

DISPATCH_FCGIRB = <<-DFCGIRB
ENV['PADRINO_ENV'] ||= 'production'
require File.expand_path("../../config/boot.rb", __FILE__)
Rack::Handler::FastCGI.run(Padrino.application)
DFCGIRB

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
DHTX

create_file destination_root('public/dispatch.fcgi'), DISPATCH_FCGI
create_file destination_root('public/dispatch_fcgi.rb'), DISPATCH_FCGIRB
create_file destination_root('public/.htaccess'), DOT_HTACCESS

unless File.read('Gemfile').include?('fcgi')
  inject_into_file destination_root('Gemfile'), "\n# DreamHost.com requirements\ngem 'fcgi'\n", :after => "source :rubygems\n"
end

require_dependencies 'fcgi'

shell.say ""
shell.say "Don't forget to make your dispatch.fcgi world-executable but not world-writable by executing"
shell.say "$ chmod 755 PADRINO_ROOT/public/dispatch.fcgi"
shell.say ""
shell.say "IMPORTANT:"
shell.say "If you need to use a different ruby version, see this source code rogit"
shell.say "http://git.io/jLwG7g"
shell.say "and change value of use_rbenv to true into dispatch.fcgi"
shell.say ""
