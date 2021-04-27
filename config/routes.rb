# frozen_string_literal: true

Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "sessions#new"
    get "/signup", to: "sessions#new"
    post "/signup", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    namespace :supervisor do
      resources :questions
      resources :exams
    end
    scope module: :trainee do
      resources :user_exams
    end
  end
end
