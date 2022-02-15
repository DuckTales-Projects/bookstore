# frozen_string_literal: true

class BooksController < ApplicationController
  def index
    @books = Book.all

    render json: @books, status: :ok
  end
end