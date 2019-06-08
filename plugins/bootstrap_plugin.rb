# Simple plugin to install Twitter bootstrap.
#
get 'https://raw.github.com/twbs/bootstrap/master/dist/css/bootstrap.css', destination_root('public/stylesheets/bootstrap.css')
get 'https://raw.github.com/twbs/bootstrap/master/dist/css/bootstrap.css.map', destination_root('public/stylesheets/bootstrap.css.map')
get 'https://raw.github.com/twbs/bootstrap/master/dist/css/bootstrap.min.css', destination_root('public/stylesheets/bootstrap.min.css')
get 'https://raw.github.com/twbs/bootstrap/master/dist/js/bootstrap.js', destination_root('public/javascripts/bootstrap.js')
get 'https://raw.github.com/twbs/bootstrap/master/dist/js/bootstrap.min.js', destination_root('public/javascripts/bootstrap.min.js')
