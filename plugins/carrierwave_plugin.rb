# Carrierwave plugin for Padrino
# sudo gem install carrierwave
# http://github.com/jnicklas/carrierwave

UPLOADER =<<-UPLOADER
class Uploader < CarrierWave::Uploader::Base

  ##
  # Image manipulator library:
  #
  # include CarrierWave::RMagick
  # include CarrierWave::ImageScience
  include CarrierWave::MiniMagick

  ##
  # Storage type
  # 
  storage :file
  # 
  # configure do |config|
  #   config.s3_access_key_id = 'AKIAJBPCWSJNLHOPAKDQ'
  #   config.s3_secret_access_key = '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'
  #   config.s3_bucket = 'assets-web'
  # end
  # 
  # storage :right_s3

  ##
  # Directory where uploaded files will be stored (default is /public/uploads)
  # 
  def store_dir
    Padrino.root('public/uploads')
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
  process :resize_to_fit => [740, 580]
  version :thumb do
    process :resize_to_fill => [100, 100]
  end
  #
  # def scale(width, height)
  #   # do something
  # end

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
  # White list of extensions which are allowed to be uploaded:
  # 
  def extension_white_list
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
require_dependencies 'carrierwave','mini_magick'
create_file destination_root('lib/uploader.rb'), UPLOADER
generate :model, "upload"
prepend_file destination_root('app/models/upload.rb'), "require 'carrierwave/orm/#{fetch_component_choice(:orm)}'\n"
inject_into_file destination_root('app/models/upload.rb'),"   mount_uploader :file, Uploader\n", :before => 'end'