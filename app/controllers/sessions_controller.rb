class SessionsController < ApplicationController
  def new; end

  def create
    @user = User.find(:first, conditions: ['user_name = ? AND password = ?', params[:user_name], params[:password]])
    if @user.present?
      set_current_user(@user)
      redirect_to root_url
    else
      render action: :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end
