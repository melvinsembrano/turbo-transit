# frozen_string_literal: true

Rails.application.routes.draw do
  resources :channels do
    resources :messages
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'channels#index'
end
