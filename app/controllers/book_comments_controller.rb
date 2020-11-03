class BookCommentsController < ApplicationController
 before_action :authenticate_user!

  def create
   	book = Book.find(params[:book_id])
    book_comment = current_user.book_comments.new(book_comment_params)
  	book_comment.book_id = book.id
  	book_comment.save
  	redirect_to book_path(book)
  end

  def destroy
    BookComment.find_by(id: params[:id], book_id: params[:book_id]).destroy
    redirect_to book_path(params[:book_id])
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:book_comment, :user_id, :book_id)
  end
  def correct_user
    @book_comment = BookComment.find(params[:id])
    if current_user != @book_comment.user
      redirect_to books_path
    end
  end
end  