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
      as :questions do
        get "/new_list_questions", to: "questions#new_list"
        post "/create_list_questions", to: "questions#create_list"
      end
      resources :exams
      resources :trainees do
        resources :user_exams
      end
      resources :users do
        collection do
          get "/trainees", to: "users#trainees_index"
          get "/supervisors", to: "users#supervisors_index"
        end
      end
    end
    scope module: :trainee do
      resources :user_exams
    end
    devise_for :users
  end
end
