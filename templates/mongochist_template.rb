# This template configures a project with the following:
# Haml
# Rightjs
# Riot
# Mongo ORM
# RR

# Determine whether mongoid or mongo_mapper is being used
say
tiny    = yes?("Do you want a tiny app structure?").present?
orm = ask("Which mongo ORM do you want to use?:(mongoid/mongo_mapper)")

project :test => :riot, :stylesheet => :sass, :renderer => :haml, :script => :rightjs, :orm => orm.gsub("_",""), :tiny => tiny, :mock => :rr

say "Configuring Machinist", :magenta
machinist = <<-MONGO
gem 'machinist', :group => 'test'
gem 'machinist_mongo', :require => 'machinist/#{orm}', :group => 'test'
MONGO

blueprints =<<-SHAM
Sham.define do
end
SHAM

inject_into_file destination_root("Gemfile"),machinist, :after => "# Test requirements\n"
create_file destination_root("test/blueprints.rb"), blueprints
inject_into_file destination_root("test/test_config.rb"), "require File.join(File.dirname(__FILE__),'blueprints')\n", :after => "/boot\")\n"