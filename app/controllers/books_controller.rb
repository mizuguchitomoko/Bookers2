class BooksController < ApplicationController
before_action :authenticate_user!, only: [:new, :create, :index, :show, :edit, :update, :destroy]

  def index
    @book = Book.new
    @books = Book.all
  end

  def show
    @book_new = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
    @book_comment = BookComment.new
    @book_comments = BookComment.all
    @users = User.all
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if  @book.save
     flash[:notice] = "book was successfully created."
     redirect_to book_path(@book)
    else
      @books = Book.all
      render :"index"
    end
  end

  def edit
   @book = Book.find(params[:id])
   @user = @book.user
   if @user != current_user
     redirect_to books_path
   end
  end

  def update
    @book = Book.find(params[:id])
    book = Book.find(params[:id])
    if book.update(book_params)
     flash[:notice] = "You have updated book successfully."
     redirect_to book_path
    else
      flash[:danger] = "error!"
      render :"edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    flash[:notice] = "Deleted successfully"
    redirect_to '/books'
  end


  private
  def book_params
    params.require(:book).permit(:title, :body)
  end

end
