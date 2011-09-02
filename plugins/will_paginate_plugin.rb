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
inject_into_file destination_root('app/app.rb'), "  register WillPaginate::Sinatra\n", :after => "Padrino::Application\n"
inject_into_file destination_root('config/boot.rb'),"  require 'will_paginate#{orm}'\n", :after => "after_load do\n"
