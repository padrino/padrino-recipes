##
# This is an extension for ActiveRecord where if I had:
#
#   post.description_ru = "I'm Russian"
#   post.description_en = "I'm English"
#   post.description_it = "I'm Italian"
#
# with this extension if I had set:
#
#   I18n.locale = :it
#
# calling directly:
#
#   post.description
#
# we get:
#
#  post.description_it => "I'm Italian"
#
# prereqs:
# sudo gem install padrino-contrib
#
require_contrib('orm/active_record/translate')
