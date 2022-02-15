# frozen_string_literal: true

class BooksController < ApplicationController
  before_action :filter, only: %i[show]
  def index
    @books = Book.all

    render json: @books, status: :ok
  end

  def show
    @books = Book.find(params[:id])

    render json: @books, status: :ok
  end

  private

  def filter
    return if Book.all.ids.include?(params[:id].to_i)

    render json: { message: "Couldnt find Book with id=#{params[:id]}" }, status: :not_found
  end
end
