##
# Better Errors plugin on Padrino
#
# https://github.com/charliesome/better_errors
#

GEMFILE = <<-GEMFILE

# Better Errors
group :development do
  gem "better_errors"
  gem "binding_of_caller"
end

GEMFILE
append_file("Gemfile", GEMFILE)

CONFIG = <<-CONFIG
# Setup better_errors
if Padrino.env == :development
  require 'better_errors'
  Padrino::Application.use BetterErrors::Middleware
  BetterErrors.application_root = PADRINO_ROOT
  BetterErrors.logger = Padrino.logger
end

CONFIG

SETTING = <<-SETTING
  # Use better_errors
  set :protect_from_csrf, except: %r{/__better_errors/\\w+/\\w+\\z} if Padrino.env == :development
SETTING

inject_into_file destination_root('config/boot.rb'), CONFIG,  :before => "Padrino.load!"
inject_into_file destination_root('config/apps.rb'), SETTING, :after  => "set :protect_from_csrf, true\n"
