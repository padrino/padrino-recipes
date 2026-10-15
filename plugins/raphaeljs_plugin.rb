##
# Plugin for installing RaphaelJS into Padrino project.
#
# Javascript files.
get 'https://raw.githubusercontent.com/DmitryBaranovskiy/raphael/master/raphael.min.js', destination_root('public/javascripts/raphael.min.js')
get 'https://raw.githubusercontent.com/DmitryBaranovskiy/raphael/master/raphael.js', destination_root('public/javascripts/raphael.js')
