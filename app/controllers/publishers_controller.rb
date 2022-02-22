# frozen_string_literal: true

class PublishersController < ApplicationController
  def index
    Publisher.all.then do |publisher|
      render json: publisher, status: :ok
    end
  end

  def show
    Publisher.find(params[:id]).then do |publisher|
      render json: publisher, status: :ok
    end
  end

  def create
    Publisher.create!(publisher_params).then do |publisher|
      render json: publisher, status: :created
    end
  end

  def update
    Publisher.find(params[:id]).update!(publisher_params).then do |publisher|
      render json: publisher, status: :no_content
    end
  end

  private

  def publisher_params
    params.require(:publisher).permit!
  end
end
