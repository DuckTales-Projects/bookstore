# frozen_string_literal: true

class AuthorsController < ApplicationController
  def index
    Author.all.then do |author|
      render json: author, status: :ok
    end
  end

  def show
    Author.find(params[:id]).then do |author|
      render json: author, status: :ok
    end
  end

  def create
    Author.create!(author_params).then do |author|
      render json: author, status: :created
    end
  end

  private

  def author_params
    params.require(:author).permit(:name)
  end
end
