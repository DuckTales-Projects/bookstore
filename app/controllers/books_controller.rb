# frozen_string_literal: true

class BooksController < ApplicationController
  before_action :filter, only: %i[show update destroy]
  before_action :params_missing?, only: %i[create]
  before_action :valid_params?, only: %i[create update]

  def index
    @books = Book.all

    render json: @books, status: :ok
  end

  def show
    @books = Book.find(params[:id])

    render json: @books, status: :ok
  end

  def create
    @book = Book.create(book_params)

    render json: @book, status: :created
  end

  def update
    @book = Book.find(params[:id])
    @book.update(book_params)

    render json: @book, status: :ok
  end

  def destroy
    @book = Book.find(params[:id]).destroy

    render json: { message: "#{@book.title} is deleted" }, status: :ok
  end

  private

  def filter
    return if Book.all.ids.include?(params[:id].to_i)

    render json: { message: "Couldnt find Book with id=#{params[:id]}" }, status: :not_found
  end

  def missing
    render json: { message: 'invalid or null parameters' }, status: :bad_request
  end

  def invalid
    render json: { message: 'invalid or null parameters' }, status: :unprocessable_entity
  end

  def params_missing?
    return missing unless params.key?(:book)

    missing unless params.require(:book).keys.count == 8
  end

  def valid_params?
    return invalid if params.require(:book).value?(nil)
  end

  def book_params
    params.require(:book).permit(:title, :genre, :language, :edition, :place, :year, :publisher_id, :author_id)
  end
end
