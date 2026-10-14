##
# Plugin for installing Font Awesome 4.7 CSS into Padrino project.
#
# CSS Stylesheets
get 'https://raw.githubusercontent.com/FortAwesome/Font-Awesome/v4.7.0/css/font-awesome.css', destination_root('public/stylesheets/font-awesome.css')
get 'https://raw.githubusercontent.com/FortAwesome/Font-Awesome/v4.7.0/css/font-awesome.min.css', destination_root('public/stylesheets/font-awesome.min.css')
# Fonts
%w(FontAwesome.otf fontawesome-webfont.eot fontawesome-webfont.svg fontawesome-webfont.ttf fontawesome-webfont.woff fontawesome-webfont.woff2).each do |font|
  get "https://raw.githubusercontent.com/FortAwesome/Font-Awesome/v4.7.0/fonts/#{font}", destination_root("public/fonts/#{font}")
end
