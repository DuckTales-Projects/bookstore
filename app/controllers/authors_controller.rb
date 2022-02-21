# frozen_string_literal: true

class AuthorsController < ApplicationController
  def index
    Author.all.then do |author|
      render json: author, status: :ok
    end
  end
end
