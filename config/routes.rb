# frozen_string_literal: true

Rails.application.routes.draw do
  concern :paginatable do
    get '(page/:page)', action: :index, on: :collection
  end

  resources :books, only: %i[index show create update destroy], concerns: :paginatable
  resources :authors, only: %i[index show create update destroy], concerns: :paginatable
  resources :publishers, only: %i[index show create update destroy], concerns: :paginatable
end
