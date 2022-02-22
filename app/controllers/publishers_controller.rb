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
end
