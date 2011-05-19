# install watchr
# $ gem install watchr
#
# Run With:
# $ watchr spec.watchr
#

# --------------------------------------------------
# Helpers
# --------------------------------------------------

def run(cmd)
  puts(cmd)
  system("rspec #{cmd}")
end

# --------------------------------------------------
# Watchr Rules
# --------------------------------------------------
watch("^lib/(.*)\.rb")                      { |m| run("spec/lib/#{m[1]}_spec.rb") }

watch("^(.*)/controllers/(.*).rb")            { |m| run("spec/#{m[1]}/controllers/#{m[2]}_controller_spec.rb") }
watch("^spec/(.*)/controllers/(.*)_spec.rb")  { |m| run("spec/#{m[1]}/controllers/#{m[2]}_spec.rb") }

watch("^(.*)/models/(.*).rb")                 { |m| run("spec/#{m[1]}/models/#{m[2]}_spec.rb") }
watch("^spec/(.*)/models/(.*)_spec.rb")       { |m| run("spec/#{m[1]}/models/#{m[2]}_spec.rb") }

watch("spec.*/spec_helper\.rb")               { system( "padrino rake spec" )   }
watch("^spec/(.*)_spec\.rb")                  { |m| run("spec/#{m[1]}_spec.rb") }

# --------------------------------------------------
# Signal Handling
# --------------------------------------------------
# Ctrl-\
Signal.trap('QUIT') do
  puts " --- Running all specs ---\n\n"
  system "padrino rake spec"
end

# Ctrl-C
Signal.trap('INT') { abort("\n") }
