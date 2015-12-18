class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
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
  
  private
  
    def user_params
      #we accept the params hash upon submission, require that the :user hash in params be valid
      #input, and allow all keys of the :user hash
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end