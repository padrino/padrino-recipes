# Add some style to Padrino. Plugin to install ZURB Foundation on Padrino
#
# Created by Felipe Cabargas <felipe@cabargas.com>
# Copyleft please!
#
get "https://github.com/felipecabargas/camorra/raw/master/css/#{file}.css", "app/stylesheets/#{file}.css"
get "https://github.com/felipecabargas/camorra/raw/master/js/#{file}.css", "public/javascripts/#{file}.js"

inject_into_file destination_root('app/stylesheets/aplication.scss'), "// Load normalize.scss as recommended by Zurb Foundation\n
@import 'normalize';\n\n// Customize certain layout settings in foundation/_settings.scss\n@import 'foundation/settings';\n\n// Use Zurb Foundation\n@import 'foundation';\n", :after => "// @include blueprint\n"

say "Hooray! Camorra is installed."
say "Now you should add Foundation JS to your layout (code below works on both SLIM and HAML):"
say " "
say "=javascript_include_tag 'foundation/foundation.js'"
say "javascript:"
say "  $(document).foundation();%"