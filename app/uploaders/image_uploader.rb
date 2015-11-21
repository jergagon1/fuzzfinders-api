class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def exif_rotation
    manipulate! do |img|
      img.auto_orient
      img = yield(img) if block_given?
      img
    end
  end

  def strip
    manipulate! do |img|
      img.strip
      img = yield(img) if block_given?
      img
    end
  end

  version :normal do
    process :exif_rotation
    process :strip

    process resize_to_fit: [1000, 1000]
  end

  version :thumb do
    process :exif_rotation
    process :strip

    process resize_to_fit: [100, 100]
  end

  def md5
    chunk = model.send(mounted_as)
    @md5 ||= Digest::MD5.hexdigest(chunk.read.to_s)
  end

  def filename
    @name ||= "#{md5}#{File.extname(super)}" if super
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
