class UsersController < ApplicationController

  before_action :authenticate_user!

  before_action :user_check, only:[:edit, :update]

  def show
  	@user = User.find(params[:id])
  	@book = Book.new
  end

  def index
  	@users = User.all
  	@book = Book.new
  end

  def edit
  end

  def update
  	if @user.update(user_params)
  		flash[:notice] = "You have updated user successfully."
  		redirect_to user_path(@user)
  	else
  		@users = User.all
  		render action: :edit
  	end
  end

  private
    def user_params
        params.require(:user).permit(:profile_image, :name, :introduction)
    end

    def user_check
    	@user = User.find(params[:id])
  	if @user != current_user
  		redirect_to user_path(current_user)
  	end
  end

end
