class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  storage :file

  process resize_to_fit: [200, 200]

  version :thumb do
    process resize_to_fit: [40, 50]
  end

  version :thumb_list do
    process resize_to_fit: [25, 25]
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def scale(width, height)
    process scale: [width, height]
  end

  def filename
    'avatar.jpg' if original_filename
  end

  def default_url(*args)
    'default_avatar.jpg'
  end

  def content_type_whitelist
    /image\//
  end
end
