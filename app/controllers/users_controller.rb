class UsersController < ApplicationController
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
  end

  def update
    @user = User.find(params[:id])
   if @user.update(user_params)
    redirect_to user_path(@user)
   else
     redirect_to edit_user_path(@user)

  end
  end

  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
