##
# This module extend ActiveRecord.
#
# You need to add to your model a column called +:permalink+
#
# then use +has_permalink :title like:
#
#   class Page < ActiveRecord::Base
#     has_permalink :page
#   end
#
# prereqs:
# sudo gem install padrino-contrib
#
require_contrib('orm/active_record/permalink')
