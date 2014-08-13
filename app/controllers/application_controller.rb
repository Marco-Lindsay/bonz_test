class ApplicationController < ActionController::Base
  include Mixins::PageNames

  protect_from_forgery

	def set_current_user(new_user)
		session[:user_id] = (new_user.nil? || new_user.is_a?(Symbol)) ? nil : new_user.id
		@current_user = new_user || nil
  end

	def current_user
		@current_user ||= set_current_user(User.where(:id => session[:user_id]).first) if session[:user_id]
	end
  helper_method :current_user

	def login_required
		if current_user
      true
    else
			flash[:error] = "Login required to do this action."
			redirect_to :controller => "blog_posts"
	    false
	  end
  end

	def blog_logged_in?
		current_user
	end
  helper_method :blog_logged_in?

	def load_blog
    blog_id = params[:blog_id] || (params[:controller] == 'blogs' && params[:id]) # A little help for trying to access a blog from '/blogs/:id'
		if(blog_id.blank? && (blog_url_identifier = params[:blog_url_id_or_id]))
			@blog = Blog.find_by_url_identifier(blog_url_identifier)
		end
		@blog_id = blog_id || (@blog && @blog.id) || blog_url_identifier || 1 # There is a default BlogSet created when the DB is bootstrapped, so we know we'll be able to fall back on this
		@blog = Blog.find(:first, :conditions => ["id = ? OR url_identifier = ?", @blog_id, @blog_id]) unless @blog
	end

	def blog_writer_or_redirect
		if @blog_id && current_user && current_user.can_blog?(@blog_id)
			true
		else
			flash[:error] = "You don't have permission to do that."
			redirect_to "/blog"
	    false
		end
	end

	def blog_comment_moderator_or_redirect
		if @blog_id && current_user && current_user.can_moderate_blog_comments?(@blog_id)
			true
		else
			flash[:error] = "You don't have permission to do that."
			redirect_to "/blog"
			false
		end
	end

	def can_modify_blogs_or_redirect
		if(current_user && current_user.can_modify_blogs?)
			true
		else
			redirect_to "/blog"
			false
		end
	end

  def get_page_name
		@page_name = look_up_page_name(params[:controller], params[:action])
  end

	# Create a named url for the blog and action combination
	def blog_named_link(blog_post, the_action = :show, options = {})
		case the_action
			when :show then "/blog/#{blog_post.blog.url_identifier}/#{blog_post.url_identifier}"
			when :index then "/blog/#{(options[:blog] || blog_post.blog).url_identifier}"
			when :feed then { :controller => 'blogs', :id => options[:blog].url_identifier, :action => :feed }
		else
			{ :controller => 'blog_posts', :action => the_action, :blog_id => (options[:blog] && options[:blog].id) || blog_post.blog_id, :id => blog_post }
		end
	end
  helper_method :blog_named_link
end
