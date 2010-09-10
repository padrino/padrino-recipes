# install watchr
# $ sudo gem install watchr
# 
# Run With:
# $ watchr test.watchr
#

# --------------------------------------------------
# Helpers
# --------------------------------------------------

def run(path)
  puts(cmd)
  system("ruby #{cmd}")
end

# --------------------------------------------------
# Watchr Rules
# --------------------------------------------------
watch("^lib.*/(.*)\.rb")                { |m| run("test/#{m[1]}_test.rb") }
watch("^app/controllers/(.*).rb")       { |m| run("test/controllers/#{m[1]}_controller_test.rb") }
watch("^test/controllers/(.*)_test.rb") { |m| run("test/controllers/#{m[1]}_test.rb")}
watch("^app/models/(.*).rb")            { |m| run("test/models/#{m[1]}_test.rb") }
watch("^test/models/(.*)_test.rb")      { |m| run("test/models/#{m[1]}_test.rb") }
watch("test.*/test_config\.rb")         { system( "padrino rake test" ) }
watch("^test/(.*)_test\.rb")            { |m| run("test/#{m[1]}_test.rb") }

# --------------------------------------------------
# Signal Handling
# --------------------------------------------------
# Ctrl-\
Signal.trap('QUIT') do
  puts " --- Running all tests ---\n\n"
  run_all_tests
end
 
# Ctrl-C
Signal.trap('INT') { abort("\n") }