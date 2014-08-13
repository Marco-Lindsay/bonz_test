require 'test_helper'

class BlogPostTest < ActiveSupport::TestCase
	 # Test our validations for new blogs
   def setup
    @blog_post = blog_posts(:blog_post_valid_and_posted)
   end

	 def test_create
 		 assert @blog_post.valid?

 		 @blog_post.blog_id = nil
 		 assert !@blog_post.valid?
 		 assert @blog_post.errors.get(:blog_id)

 		 user = users(:users_001)
 		 def user.can_blog?(_blog_id = nil)
  			 false
  		end
 		 @blog_post.posted_by = user
 		 assert !@blog_post.valid?
 		 assert @blog_post.errors.get(:posted_by_id)
 	end

	 def test_url_identifier
 		 @blog_post.is_complete = false
 		 @blog_post.title = 'My first blog'
 		 @blog_post.save
 		 assert_equal @blog_post.url_identifier, 'My_first_blog'

 		 @blog_post.is_complete = true
 		 @blog_post.title = 'My second blog'
 		 @blog_post.save
 		 assert_equal @blog_post.url_identifier, 'My_first_blog'
 	end

	 def test_tag_creation
 		 @blog_post.tag_string = 'Pony, horsie, doggie'
 		 @blog_post.save
 		 assert_equal @blog_post.tags.size, 3

 		 @blog_post.tag_string = 'Parrot'
 		 @blog_post.save
 		 assert_equal @blog_post.tags.size, 1
 	end
end
