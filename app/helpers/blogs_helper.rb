module BlogsHelper
	# Create a fully-qualified named url for the blog and action combination
	def qualified_blog_named_link(blog_post, the_action = :show, options = {})
		common_hash = { :only_path => false }
		blog = options[:blog] || (blog_post && blog_post.blog)
		common_hash.merge!(:host => blog.canonical_domain) unless !blog || blog.canonical_domain.blank?

		case the_action
			when :show then url_for({:controller => 'blog', :action => blog_post.blog.url_identifier, :id => blog_post.url_identifier}.merge(common_hash))
			when :index then url_for({:controller => 'blog', :action => (options[:blog] || blog_post.blog).url_identifier}.merge(common_hash))
			when :feed then url_for({:controller => 'blogs', :id => options[:blog].url_identifier, :action => :feed}.merge(common_hash))
		else
			url_for({:controller => 'blog_posts', :action => the_action, :blog_id => (options[:blog] && options[:blog].id) || blog_post.blog_id, :id => blog_post}.merge(common_hash))
		end
	end
end
