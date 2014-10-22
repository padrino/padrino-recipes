# VCR Plugin
#
# Adds VCR to your test config using fakeweb.
#
VCR = <<-CONF

VCR.config do |c|
  c.cassette_library_dir = File.expand_path('../fixtures/', __FILE__)
  c.stub_with :webmock
  c.default_cassette_options = { :record => :new_episodes }
end
CONF

test = fetch_component_choice(:test)
path = test == 'rspec' || test == 'cucumber' ? 'spec/spec_helper.rb' : 'test/test_config.rb'

append_file destination_root(path), VCR
require_dependencies 'vcr', 'webmock', :group => :test
