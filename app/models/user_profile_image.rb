# == Schema Information
#
# Table name: user_profile_images
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  parent_id    :integer
#  content_type :string(255)
#  filename     :string(255)
#  thumbnail    :string(255)
#  size         :integer
#  width        :integer
#  height       :integer
#  created_at   :datetime
#

class UserProfileImage < ActiveRecord::Base
  belongs_to :user

  FILENAME_LENGTH = 8
  has_attachment content_type: :image,
                 storage: :file_system,
                 min_size: 100.bytes,
                 max_size: 6096.kilobytes,
                 resize_to: '640x640>',	# This sets the maximum size of a side.  Aspect ratio is maintained, but the image scales so that its largest side is the size specified here.
                 thumbnails: { thumb48: 'c60x60', thumb128: 'c128x128&iquality=90', thumb175: 'c175x175&iquality=90' },
									        processor: 'Rmagick' # "ImageScience" # Kropper also supports Rmagick, as you can see below

  validates_as_attachment

	 after_create { |pic| pic.user.update_attribute(:has_picture, true) if pic.user }

  # ---------------------------------------------------------------------------
	 def thumb48_path
 		 public_filename(:thumb48)
   end

  # ---------------------------------------------------------------------------
  def thumb128_path
    public_filename(:thumb128)
  end

  # ---------------------------------------------------------------------------
	 def public_path_full_size
 		 thumbnails.size > 1 ? public_filename(:thumb128) : public_filename
   end

  # ---------------------------------------------------------------------------
  def ensure_thumb175
    if thumbnails.none? { |t| t.thumbnail == 'thumb175' }
      create_thumbnail_size(:thumb175) rescue nil
    end
  end
end
