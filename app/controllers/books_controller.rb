class BooksController < ApplicationController
  def index
    @book = Book.new
    @books = Book.all
    @users = User.all
  end

  def show
    @book = Book.find(params[:id])
     @user = User.find(@book.user_id)

  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @book.save
   flash[:notice] = "book was successfully created."
    redirect_to '/books'#book_path(@book.id)
  end

  def edit
   @book = Book.find(params[:id])
   
  end

  def update
    book = Book.find(params[:id])
    book.update(book_params)
    redirect_to '/books'
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to '/books'
  end


  private
  def book_params
    params.require(:book).permit(:title, :body)
  end

end
