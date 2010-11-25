# Simple Auto-Test Watchr script generation.
# TODO: add other types of watchr scripts.
component = fetch_component_choice(:test)
if component == 'none'
  say "Installation cancelled. No testing framework found.", :red
else
  test = case component; when 'rspec', 'cucumber' then 'spec'; else 'test'; end
  get "https://github.com/padrino/padrino-recipes/raw/master/files/watchrs/#{test}.watchr", destination_root("#{test}.watchr")
end