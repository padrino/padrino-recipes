# Simple Auto-Test Watchr script generation.
# TODO: add other types of watchr scripts.
component = fetch_component_choice(:test)
test = (component == 'rspec' ? 'spec' : 'test')
get "http://github.com/padrino/padrino-recipes/raw/master/files/watchrs/#{test}.watchr", destination_root("#{test}.watchr")