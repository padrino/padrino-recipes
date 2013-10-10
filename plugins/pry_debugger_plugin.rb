##
# PRY Debugger on Padrino
#

LIB = <<-LIB
begin
  require 'pry'
  $VERBOSE = nil
  IRB = Pry
  $VERBOSE = false
rescue LoadError
end
LIB

create_file 'lib/pry-padrino.rb', LIB

GEMFILE = <<-GEMFILE
group 'test', 'development' do
  gem 'pry'
  gem 'pry-doc'
  gem 'pry-nav'
  gem 'pry-stack_explorer'
  gem 'bond'
end
gem 'plymouth', require: false, group: 'test'
GEMFILE

append_file('Gemfile', GEMFILE)

inject_into_file destination_root('test/test_config.rb'), "require 'plymouth'",
  after: "require File.expand_path('../../config/boot', __FILE__)\n"
