# == Schema Information
#
# Table name: blog_comments
#
#  id                     :integer          not null, primary key
#  user_id                :integer
#  blog_post_id           :integer
#  comment                :text
#  approved               :boolean
#  created_at             :datetime
#  updated_at             :datetime
#  response_to_comment_id :integer
#  featured               :boolean
#

class BlogComment < ActiveRecord::Base
	 attr_protected :approved

	 belongs_to :user
	 belongs_to :blog_post
	 belongs_to :response_to, class_name: 'BlogComment', foreign_key: :response_to_comment_id
	 has_many :responses, class_name: 'BlogComment', foreign_key: :response_to_comment_id

	 scope :is_response, lambda { |true_or_false| where(["response_to_comment_id IS #{true_or_false ? 'NOT NULL' : 'NULL'}"]) }
	 scope :featured, where(featured: true)

	 validates_presence_of :blog_post_id, :user_id, :comment
	 before_create :determine_approval

	 # --------------------------------------------------------------------------------------
	 def response?
 		 response_to
 	end

	 # --------------------------------------------------------------------------------------
	 # --------------------------------------------------------------------------------------
	 private
	 # --------------------------------------------------------------------------------------
	 # --------------------------------------------------------------------------------------

	 def determine_approval
 		 self.approved = if blog_post && user && user.blog_comment_auto_approved?(blog_post: blog_post)
  			                 true
  		else
  			 nil
  		end
 		 true
 	end
end
