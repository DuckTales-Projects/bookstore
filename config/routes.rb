# frozen_string_literal: true

Rails.application.routes.draw do
  resources :books, only: %i[index show create update destroy]
  resources :authors, only: %i[index]
end
