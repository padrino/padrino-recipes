# Simple plugin to install Twitter bootstrap.
#
get 'https://raw.github.com/twitter/bootstrap/master/docs/assets/css/bootstrap.css', destination_root('public/stylesheets/bootstrap.css')
get 'https://raw.github.com/twitter/bootstrap/master/docs/assets/css/bootstrap-responsive.css', destination_root('public/stylesheets/bootstrap-responsive.css')
get 'https://raw.github.com/twitter/bootstrap/master/docs/assets/js/bootstrap.js', destination_root('public/javascripts/bootstrap.js')
get 'https://raw.github.com/twitter/bootstrap/master/docs/assets/js/bootstrap.min.js', destination_root('public/javascripts/bootstrap.min.js')
get 'https://raw.github.com/twitter/bootstrap/master/docs/assets/img/glyphicons-halflings.png', destination_root('public/images/glyphicons-halflings.png')
get 'https://raw.github.com/twitter/bootstrap/master/docs/assets/img/glyphicons-halflings-white.png', destination_root('public/images/glyphicons-halflings-white.png')