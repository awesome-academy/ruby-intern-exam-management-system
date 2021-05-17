# frozen_string_literal: true

Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "sessions#new"
    as :user do
      get "/signup", to: "devise/sessions#new"
      post "/signup", to: "devise/sessions#create"
      delete "/logout", to: "devise/sessions#destroy"
    end
    scope module: :supervisor do
      resources :questions
      resources :exams
      resources :trainees do
        resources :user_exams
      end
    end
    scope module: :trainee do
      resources :user_exams
    end
    devise_for :users
  end
end
