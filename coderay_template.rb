# Template to get Coderay on Padrino

CODERAY = <<-CODERAY
    require 'rack/coderay'
    app.use Rack::Coderay,
        "//pre[@lang]",
        :line_numbers => :table
CODERAY
require_dependencies 'coderay', 'rack-coderay'
initializer :coderay,CODERAY
get 'http://coderay.rubychan.de/stylesheets/coderay.css', 'public/stylesheets/coderay.css'