##
# Plugin for installing Font Awesome CSS into Padrino project.
#
# CSS Stylesheets
get 'https://raw.github.com/FortAwesome/Font-Awesome/master/css/font-awesome.css', destination_root('public/stylesheets/font-awesome.css')
get 'https://raw.github.com/FortAwesome/Font-Awesome/master/css/font-awesome.min.css', destination_root('public/stylesheets/font-awesome.min.css')
# Fonts
get 'https://raw.github.com/FortAwesome/Font-Awesome/master/fonts/FontAwesome.otf', destination_root('public/fonts/FontAwesome.otf')
get 'https://raw.github.com/FortAwesome/Font-Awesome/master/fonts/fontawesome-webfont.eot', destination_root('public/fonts/fontawesome-webfont.eot')
get 'https://raw.github.com/FortAwesome/Font-Awesome/master/fonts/fontawesome-webfont.svg', destination_root('public/fonts/fontawesome-webfont.svg')
get 'https://raw.github.com/FortAwesome/Font-Awesome/master/fonts/fontawesome-webfont.ttf', destination_root('public/fonts/fontawesome-webfont.ttf')
get 'https://raw.github.com/FortAwesome/Font-Awesome/master/fonts/fontawesome-webfont.woff', destination_root('public/fonts/fontawesome-webfont.woff')
