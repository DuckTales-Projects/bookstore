# frozen_string_literal: true

class PublishersController < ApplicationController
  def index
    Publisher.order(:id).page(params[:page]).then do |publishers|
      page = params[:page].to_i
      total_pages = Publisher.page(1).total_pages
      total_publishers = Publisher.all.size

      render json: {
        list: publishers,
        pagination: "#{page} of #{total_pages}",
        total_publishers: total_publishers
      }, status: :ok
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

  def destroy
    Publisher.find(params[:id]).destroy.then do |publisher|
      render json: { message: "#{publisher.name} was deleted" }, status: :ok
    end
  end

  private

  def publisher_params
    params.require(:publisher).permit!
  end
end
