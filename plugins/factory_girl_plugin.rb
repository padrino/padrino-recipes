##
# Add FactoryGirl to Padrino
#
LIB = <<-LIB
begin
  require 'factory_girl'
  # Sequel does not have a save! method
  if defined?(Sequel)
    FactoryGirl.define do
      to_create { |instance| instance.save }
    end
  end
  FactoryGirl.find_definitions
rescue LoadError
end
LIB

create_file 'lib/factory_girl.rb', LIB

GEMFILE = <<-GEMFILE
group :development, :test do
  gem 'factory_girl'
end
GEMFILE

append_file('Gemfile', GEMFILE)
