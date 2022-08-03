# frozen_string_literal: true

class BooksController < ApplicationController
  def index
    @books = Book.order(:id).page(params[:page])
  end

  def show
    @book = Book.find(params[:id])
  end

  def create
    Book.create!(book_params).then do |book|
      render json: book, status: :created
    end
  end

  def update
    Book.find(params[:id]).then do |book|
      book.update!(book_params).then do |result|
        render json: result, status: :no_content
      end
    end
  end

  def destroy
    Book.find(params[:id]).destroy.then do |book|
      render json: { message: "#{book.title} was deleted" }, status: :ok
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :genre, :language, :edition, :place, :year, :publisher_id, :author_id)
  end
end
