##
# Template to get will_paginate on Padrino
# prereqs:
#
# will_paginate provides orm integration with active_record, datamapper,
# and sequel out of the box.
#
# https://github.com/mislav/will_paginate/wiki/Installation
#

orm = (choice = fetch_component_choice(:orm)) =~ /sequel|activerecord|datamapper/ ? choice : ""
orm = '/data_mapper'   if orm == "datamapper"
orm = '/active_record' if orm == "activerecord"
orm = '/sequel'        if orm == "sequel"
inject_into_file destination_root('config/boot.rb'),
  "  require 'will_paginate'\n" +
  "  require 'will_paginate#{orm}'\n" +
  "  require 'will_paginate/view_helpers/sinatra'\n" +
  "  include WillPaginate::Sinatra::Helpers\n",
  :after => "before_load do\n"
inject_into_file destination_root('app/app.rb'), 
  "  register WillPaginate::Sinatra\n", 
  :after => "Padrino::Application\n"
inject_into_file destination_root('Gemfile'),
  "gem 'will_paginate', '~>3.0'\n",
  :after => "Component requirements\n"

say '='*65, :green
say "The 'will_paginate' plugin has been installed!"
say "Next, follow these steps:"
say "Run 'bundle install'"
say "Start (or restart) the padrino server"
say '='*65, :green
=begin
puts '='*65
puts "The 'will_paginate' plugin has been installed!"
puts "Next, follow these steps:"
puts "Run 'bundle install'"
puts "Start (or restart) the padrino server"
puts '='*65
=end
