##
# Make Padrino use Pry and pry-byebug
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

create_file 'lib/pry-byebug.rb', LIB

GEMFILE = <<-GEMFILE
group :development, :test do
  gem 'pry-byebug'
end
GEMFILE

append_file('Gemfile', GEMFILE)
