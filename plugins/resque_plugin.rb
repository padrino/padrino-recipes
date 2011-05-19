##
# Resque Plugin for Padrino
# gem install resque
# https://www.github.com/defunkt/resque
#
INIT =<<-INIT
padrino_env   = ENV["PADRINO_ENV"] ||= ENV["RACK_ENV"] ||= "development"
resque_config = YAML.load_file Padrino.root('config','resque.yml')
Resque.redis  = resque_config[padrino_env]
INIT

CONFIG =<<-CONFIG
development: localhost:6379
test: localhost:6379
production: localhost:6379
CONFIG

RAKE =<<-RAKE
require 'resque/tasks'

namespace :resque do
  desc "Load the Application Development for Resque"
  task :setup => :environment do
    ENV['QUEUES'] = '*'
    # ENV['VERBOSE']  = '1' # Verbose Logging
    # ENV['VVERBOSE'] = '1' # Very Verbose Logging
  end
end
RAKE

create_file destination_root('lib/resque_init.rb'), INIT
create_file destination_root('config/resque.yml'), CONFIG
create_file destination_root('lib/tasks/resque.rake'), RAKE
require_dependencies 'resque'
