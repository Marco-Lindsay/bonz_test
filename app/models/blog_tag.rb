# == Schema Information
#
# Table name: blog_tags
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  blog_post_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class BlogTag < ActiveRecord::Base
	belongs_to :blog_post
end
