##
# This module extend ActiveRecord.
#
# You need to add to your model a column called +:permalink+
#
# then use +has_permalink :title like:
#
#   class Page < ActiveRecord::Base
#     has_permalink :page, :langs => [:en, :fr, :de]
#   end
#
# prereqs:
# sudo gem install padrino-contrib
#
require_contrib('orm/ar/permalink_i18n')