##
# Template to get better_errors on Padrino
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

inject_into_file destination_root('config/boot.rb'), CONFIG, :after => "Bundler.require(:default, PADRINO_ENV)\n"