##
# This module generate html from textile.
#
# In your ActiveRecord class you need only to add:
#
#   has_textile :body, :internal_links => :page
#
# In your body you can write (like github) internal links:
#
#   [[Page Name|link me]]
#
#
# prereqs:
# sudo gem install padrino-contrib
# sudo gem install RedCloth
#
require_contrib('orm/active_record/textile')
require_dependency('RedCloth')
