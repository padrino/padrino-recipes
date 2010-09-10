# Determine whether mongoid or mongo_mapper is being used
say
tiny    = yes?("Do you want a tiny app structure?").present?
orm = ask("Which mongo ORM do you want to use?:(mongoid/mongo_mapper)")

project :test => options[:test], :stylesheet => options[:stylesheet], :renderer => options[:renderer], :script => options[:script], :orm => orm.gsub("_",""), :tiny => tiny, :mock => options[:mock]

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