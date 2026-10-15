##
# Add FactoryBot to Padrino
#
LIB = <<-LIB
begin
  require 'factory_bot'
  # Sequel does not have a save! method
  if defined?(Sequel)
    FactoryBot.define do
      to_create { |instance| instance.save }
    end
  end
  FactoryBot.find_definitions
rescue LoadError
end
LIB

create_file 'lib/factory_bot.rb', LIB

GEMFILE = <<-GEMFILE
group :development, :test do
  gem 'factory_bot'
end
GEMFILE

append_file('Gemfile', GEMFILE)
