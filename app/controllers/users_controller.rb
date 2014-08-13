class UsersController < ApplicationController
  before_filter :login_required, only: [:edit, :update, :destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      if params[:avatar]
    		  avatar = UserProfileImage.new(params[:avatar])
    		  avatar.user_id = @user.id
    		  avatar.save!
      end
      set_current_user(@user)
      flash[:notice] = 'You have been registered!'
      redirect_to root_url
    else
      render action: :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      if @user.avatar.present?
        @user.avatar.update_attributes(params[:avatar])
      else
    		  avatar = UserProfileImage.new(params[:avatar])
    		  avatar.user_id = @user.id
    		  avatar.save!
      end

      flash[:notice] = 'You account has been updated!'
      redirect_to root_url
    else
      render action: :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    flash[:notice] = 'The user has been deleted'
    redirect_to root_url
  end
end
