# Add some style to Padrino. Plugin to install ZURB Foundation on Padrino
#
# Created by Felipe Cabargas <felipe@cabargas.com>
# Copyleft please!
#
# SCSS
get "https://raw.github.com/felipecabargas/camorra/master/assets/scss/foundation.scss", "app/stylesheets/foundation.scss"
get "https://raw.github.com/felipecabargas/camorra/master/assets/scss/normalize.scss", "app/stylesheets/normalize.scss"
get "https://raw.github.com/felipecabargas/camorra/master/assets/scss/foundation/_functions.scss", "app/stylesheets/foundation/_functions.scss"
get "https://raw.github.com/felipecabargas/camorra/master/assets/scss/foundation/_settings.scss", "app/stylesheets/foundation/_settings.scss"
get "https://raw.github.com/felipecabargas/camorra/master/assets/scss/foundation/components/#{file}.scss", "app/stylesheets/foundation/components/#{file}.scss"

# JS
get "https://raw.github.com/felipecabargas/camorra/master/assets/js/#{file}.js", "public/javascripts/#{file}.js"
get "https://raw.github.com/felipecabargas/camorra/master/assets/js/vendor/#{file}.js", "public/javascripts/vendor/#{file}.js"
get "https://raw.github.com/felipecabargas/camorra/master/assets/js/foundation/#{file}.js", "public/javascripts/foundation/#{file}.js"

inject_into_file destination_root('app/stylesheets/aplication.scss'), "// Load normalize.scss as recommended by Zurb Foundation\n
@import 'normalize';\n\n// Customize certain layout settings in foundation/_settings.scss\n@import 'foundation/settings';\n\n// Use Zurb Foundation\n@import 'foundation';\n", :after => "// @include blueprint\n"

say "Hooray! Camorra is installed."
say "Now you should add Foundation JS to your layout (code below works on both SLIM and HAML):"
say " "
say "=javascript_include_tag 'foundation/foundation.js'"
say "javascript:"
say "  $(document).foundation();%"