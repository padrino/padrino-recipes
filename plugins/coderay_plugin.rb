# Template to get Coderay on Padrino
# prereqs:
# sudo gem install coderay
# sudo gem install rack-coderay
# http://github.com/webficient/rack-coderay
CODERAY = <<-CODERAY
    app.use Rack::Coderay,
        "//pre[@lang]",
        :line_numbers => :table
CODERAY
require_dependencies 'coderay', 'rack-coderay'
initializer :coderay,CODERAY
get 'http://coderay.rubychan.de/stylesheets/coderay.css', destination_root('public/stylesheets/coderay.css')