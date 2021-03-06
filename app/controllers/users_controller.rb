class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :following, :followers]
  # very important to have, for security purposes! 
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: [:destroy]
  # limits destroy action to admins only
  
  def index
    @users = User.paginate(page: params[:page])
    # params[:page] generated from the will_paginate gem
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end
  
  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
      #rails automatically infers from this that it should redirect to user_url(@user)
    else
      render 'new'
    end
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end
  
  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end
  
  private
  
    def user_params
      #we accept the params hash upon submission, require that the :user hash in params be valid
      #input, and allow all keys of the :user hash
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
    
    
#   Confirms a logged in user.
# => This code moved to the application controller, so that the micropost controller can inherit and use it
#    def logged_in_user
#      unless logged_in? 
#        store_location
#        flash[:danger] = "Please log in."
#        redirect_to login_url
#      end
#    end
    
    # Confirms the correct user. 
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
    
    # Confirms an admin user. 
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end