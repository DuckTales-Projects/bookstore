# frozen_string_literal: true

class AuthorsController < ApplicationController
  def index
    @authors = Author.order(:id).page(params[:page])
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

  def update
    Author.find(params[:id]).update!(author_params).then do |author|
      render json: author, status: :no_content
    end
  end

  def destroy
    Author.find(params[:id]).destroy.then do |author|
      render json: { message: "#{author.name} was deleted" }, status: :ok
    end
  end

  private

  def author_params
    params.require(:author).permit(:name)
  end
end
