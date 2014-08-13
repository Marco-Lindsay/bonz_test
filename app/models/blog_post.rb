# == Schema Information
#
# Table name: blog_posts
#
#  id              :integer          not null, primary key
#  title           :string(255)
#  body            :text
#  is_indexed      :boolean
#  tag_string      :string(255)
#  posted_by_id    :integer
#  is_complete     :boolean
#  created_at      :datetime
#  updated_at      :datetime
#  url_identifier  :string(255)
#  category_id     :integer
#  comments_closed :boolean
#  fck_created     :boolean
#  blog_id         :integer          default(1)
#  is_moderated    :boolean          default(FALSE)
#

class BlogPost < ActiveRecord::Base
	 xss_terminate except: [:body]

	 belongs_to :posted_by, class_name: 'User'
  belongs_to :category, class_name: 'BlogCategory'
	 has_many :comments, class_name: 'BlogComment'
	 has_many :approved_comments, conditions: %(approved = true), class_name: 'BlogComment'
	 has_many :pending_approval_comments, conditions: ['approved IS NULL'], class_name: 'BlogComment'
	 has_many :assets, class_name: 'BlogAsset'
	 has_many :tags, class_name: 'BlogTag'
	 belongs_to :blog

	 validates_presence_of :blog_id, :posted_by_id
	 validate :authorized_to_blog?

	 after_save :save_tags
	 before_save :update_url_identifier

	 def comments_closed?
 		 comments_closed || (created_at < 1.week.ago)
 	end

	 # --------------------------------------------------------------------------------------
	 # --------------------------------------------------------------------------------------
	 private
	 # --------------------------------------------------------------------------------------
	 # --------------------------------------------------------------------------------------

	 def update_url_identifier
 		 # We won't update URL identifier if ther'es no title, or if this blog was already published
 		 # with a URL identifier (don't want links to get broken)
 		 return if title.blank? || (is_complete && !url_identifier.blank?)
 		 self.url_identifier = title.strip.gsub(/\W/, '_')
 		 true
 	end

	 def authorized_to_blog?
 		 unless posted_by && posted_by.can_blog?(blog_id)
  			 errors.add(:posted_by_id, 'is not authorized to post to this blog')
  		end
 	end

	 def save_tags
 		 return if tag_string.blank? || !self.tag_string_changed?
 		 BlogTag.delete_all(['blog_post_id = ?', id])
 		 these_tags = tag_string.split(',')
 		 these_tags.each do |tag|
  			 sanitary_tag = tag.strip.chomp
  			 BlogTag.create(name: sanitary_tag, blog_post_id: id)
  		end
 	end
end
