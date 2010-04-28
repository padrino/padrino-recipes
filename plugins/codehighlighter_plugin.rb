# Template to get CodeHighlighter on Padrino
# prereqs:
# sudo gem install rack-codehighlighter
# http://github.com/wbzyl/rack-codehighlighter
HIGHLIGHTER = <<-HIGHLIGHTER
    app.use Rack::Codehighlighter, :coderay, :element => "pre", :pattern => /\A:::(\w+)\s*\n/
HIGHLIGHTER
require_dependencies 'coderay'
require_dependencies 'rack-codehighlighter', :require => 'rack/codehighlighter'
initializer :codehighlighter,HIGHLIGHTER