class UsersController < ApplicationController
   before_action :authenticate_user!

  def index
    @book = Book.new
    @books = Book.all
    @users = User.all
  end

  def show
    @book_new = Book.new
    @user = User.find(params[:id])
    @books = @user.books.all
   #imageを渡す記述
  end

  def new
  end

  def edit
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
   if @user.update(user_params)
    flash[:notice] = "You have updated user successfully."
    redirect_to user_path(@user.id)
   else
     flash[:danger] = @user.errors.full_messages
     render "edit"
   end
  end

  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
