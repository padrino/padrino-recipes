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
AR_TRANSLATE <<-RUBY
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
# we get
#
#  post.description_it => "I'm Italian"
#
module ArTranslate

  module ClassMethods
    def has_locale
      include InstanceMethods
    end
  end # ClassMethods

  module InstanceMethods
    def method_missing(method_name, *arguments)
      attribute = "\#{method_name}_\#{I18n.locale}".to_sym
      return self.send(attribute) if I18n.locale.present? && self.respond_to?(attribute)
      super
    end
  end # InstanceMethods
end # ArTranslate
ActiveRecord::Base.extend(ArTranslate::ClassMethods)
RUBY

create_file "lib/ar_translate.rb", AR_TRANSLATE