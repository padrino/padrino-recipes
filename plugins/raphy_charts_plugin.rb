##
# Plugin for installing Raphy Charts (RaphaelJS based HTML5/SVG charts) into a Padrino project.
# Must also install the RaphaelJS library and include both into your project views.
#
# Javascript files.
get 'https://raw.github.com/jcarver989/raphy-charts/master/compiled/charts.js', destination_root('public/javascripts/raphy-charts.js')
get 'https://raw.github.com/jcarver989/raphy-charts/master/compiled/charts.min.js', destination_root('public/javascripts/raphy-charts.min.js')
