##
# Carrierwave plugin for Padrino
# sudo gem install carrierwave
# http://github.com/jnicklas/carrierwave
#
UPLOADER = <<-UPLOADER
class Uploader < CarrierWave::Uploader::Base

  ##
  # Image manipulator library:
  #
  # include CarrierWave::RMagick
  # include CarrierWave::ImageScience
  # include CarrierWave::MiniMagick

  ##
  # Storage type
  #
  storage :file
  # configure do |config|
  #   config.fog_credentials = {
  #     :provider              => 'XXX',
  #     :aws_access_key_id     => 'YOUR_ACCESS_KEY',
  #     :aws_secret_access_key => 'YOUR_SECRET_KEY'
  #   }
  #   config.fog_directory = 'YOUR_BUCKET'
  # end
  # storage :fog



  ## Manually set root
  def root; File.join(Padrino.root,"public/"); end

  ##
  # Directory where uploaded files will be stored (default is /public/uploads)
  #
  def store_dir
    'images/uploads'
  end

  ##
  # Directory where uploaded temp files will be stored (default is [root]/tmp)
  #
  def cache_dir
    Padrino.root("tmp")
  end

  ##
  # Default URL as a default if there hasn't been a file uploaded
  #
  # def default_url
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  ##
  # Process files as they are uploaded.
  #
  # process :resize_to_fit => [740, 580]

  ##
  # Create different versions of your uploaded files
  #
  # version :header do
  #   process :resize_to_fill => [940, 250]
  #   version :thumb do
  #     process :resize_to_fill => [230, 85]
  #   end
  # end
  ##
  # Extensions which are allowed to be uploaded (needs CarrierWave 2.2 or later):
  #
  def extension_allowlist
    %w(jpg jpeg gif png)
  end

  ##
  # Override the filename of the uploaded files
  #
  # def filename
  #   "something.jpg" if original_filename
  # end
end
UPLOADER
# Generate the model first: the generator boots the app, and lib/uploader.rb
# can't load until CarrierWave is bundled. On Mongoid, mount_uploader defines the field.
generate :model, fetch_component_choice(:orm) == 'mongoid' ? "upload" : "upload file:text"
create_file destination_root('lib/uploader.rb'), UPLOADER

case fetch_component_choice(:orm)
when 'mini_record'
  prepend_file destination_root('models/upload.rb'), "require 'carrierwave/orm/activerecord'\n"
when 'datamapper'
  prepend_file destination_root('models/upload.rb'), "require 'carrierwave/datamapper'\n"
  inject_into_file destination_root('models/upload.rb'),", :auto_validation => false\n", :after => "property :file, Text"
  require_dependencies 'carrierwave-datamapper', :require => 'carrierwave/datamapper'
when 'mongoid'
  require_dependencies 'carrierwave-mongoid', :require => 'carrierwave/mongoid'
when 'sequel'
  require_dependencies 'carrierwave-sequel', :require => 'carrierwave/sequel'
else
  prepend_file destination_root('models/upload.rb'), "require 'carrierwave/orm/#{fetch_component_choice(:orm)}'\n"
end

require_dependencies 'carrierwave', :version => '>= 2.2'
inject_into_file destination_root('models/upload.rb'),"   mount_uploader :file, Uploader\n", :before => 'end'
