# == Schema Information
#
# Table name: blog_assets
#
#  id           :integer          not null, primary key
#  blog_post_id :integer
#  parent_id    :integer
#  content_type :string(255)
#  filename     :string(255)
#  thumbnail    :string(255)
#  size         :integer
#  width        :integer
#  height       :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class BlogAsset < ActiveRecord::Base
	 belongs_to :blog_post

	 has_attachment content_type: :image,
 		              storage: :file_system,
 		              min_size: 100.bytes,
 		              max_size: 6.megabytes,
 		              resize_to: '700x700>',	# This sets the maximum size of a side.  Aspect ratio is maintained, but the image scales so that its largest side is the size specified here.
 		              thumbnails: { thumb200: '350x350' }, # See http://www.imagemagick.org/RMagick/doc/imusage.html#geometry to find out what this means
 		              processor: 'Rmagick'

	 validates_as_attachment
end
