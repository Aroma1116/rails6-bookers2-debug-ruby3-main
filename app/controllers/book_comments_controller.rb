class BookCommentsController < ApplicationController

  def create
    @book = Book.find(params[:book_id])
    @book_comment = current_user.book_comments.new(book_comment_params)
    @book_comment.book_id = @book.id
    if @book_comment.save
      flash.now[:notice] = 'コメントを投稿しました'
      render 'book_comments'
    else
      @user = @book.user
      render :error
    end
  end

  def destroy
    BookComment.find(params[:id]).destroy
    @book = Book.find(params[:book_id])
    flash.now[:alert] = 'コメントを削除しました'
    render 'book_comments'
  end

  private
  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
