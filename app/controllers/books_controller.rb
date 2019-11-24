class BooksController < ApplicationController

  before_action :authenticate_user!

  before_action :user_check, only:[:edit, :update]

  def index
  	@book = Book.new
  	@books = Book.all
  end

  def show
    @newbook = Book.new
  	@book = Book.find(params[:id])
  end

  def new
  end

  def create
  	@book = Book.new(book_params)
    @book.user_id = current_user.id
  	if @book.save
  		flash[:notice] = "You have creatad book successfully."
  		redirect_to book_path(@book.id)
  	else
  		@books = Book.all
  		render action: :index
  	end
  end

  def edit
  end

  def update
  	if @book.update(book_params)
  		flash[:notice] = "You have updated book successfully."
  		redirect_to book_path(@book.id)
  	else
  		@books = Book.all
  		render action: :edit
  	end
  end

  def destroy
  	book = Book.find(params[:id])
  	book.destroy
  	redirect_to books_path
  end

  private
    def book_params
  	  params.require(:book).permit(:title, :body)
    end

    def user_check
        @book = Book.find(params[:id])
    if @book.user != current_user
        redirect_to books_path
    end
  end
end
