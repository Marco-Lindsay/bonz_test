class BlogCommentsController < ApplicationController
	helper :blogs
	before_filter :login_required
	before_filter :load_blog_comment, :only => [:approve, :approval_decision, :destroy, :edit, :feature, :update]
	before_filter :blog_comment_moderator_or_redirect, :only => [:approve, :destroy, :feature]
	
  # POST /blogs_comments
	# POST /blogs_comments.xml
	def create
		@blog_comment = BlogComment.new(params[:blog_comment])
		@blog_comment.user_id = current_user.id
		
		@blog_comment.save
		@blog_post = @blog_comment.blog_post
		redirect_to(blog_named_link(@blog_post))
	end

	def edit
	end

	def update
		@blog_comment.update_attributes(params[:blog_comment])
		redirect_to(blog_named_link(@blog_post))
	end
	
  def destroy
		@blog_comment.destroy
		redirect_to(params[:referring_url])
	end
	
	def approve
		flash[:message] = "Comment was approved!"
		@blog_comment.update_attribute(:approved, true)
		redirect_to(params[:referring_url])
	end

  def feature
    @blog_comment.update_attribute(:featured, !@blog_comment.featured)

    if request.xhr?
      render :text => @blog_comment.featured ? 'Featured' : 'Unfeatured'
    else
      redirect_to blog_named_link(@blog_comment.blog_post)
    end
  end

	def approval_decision
		if(comment_params = params[:comment_approval])
			@blog_comment.update_attribute(:approved, true) if comment_params[:decision] == 'approve'
			@blog_comment.update_attribute(:approved, false) if comment_params[:decision] == 'disapprove'

			if(comment_params[:response].present?)
				new_comment = BlogComment.new(:user_id => current_user.id, :blog_post_id => @blog_post.id,
					:comment => comment_params[:response], :response_to_comment_id => @blog_comment.id)
				new_comment.approved = true
				new_comment.save!

				@blog_comment.update_attribute(:approved, true)
			end
		end

		if(@blog_comment.approved)
			render :partial => "blog_comments/show", :locals => { :blog_post => @blog_post, :comment => @blog_comment }
		else
			render :nothing => true
		end
	end
	
	def load_blog_comment 
		@blog_comment = BlogComment.find(params[:id])
		@blog_post = @blog_comment.try(:blog_post)
		@blog = @blog_post.try(:blog)
		@blog_id = @blog && @blog.id
		unless current_user && @blog_comment && ((current_user == @blog_comment.user) || (current_user.can_moderate_blog_comments?(@blog && @blog.id)))
			flash[:error] = "You don't have permission to edit that comment"
			redirect_to blog_named_link(@blog_post)
			false
		else
			true
		end
	end
end
