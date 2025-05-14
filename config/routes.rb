Rails.application.routes.draw do
  resource :session
  resource :registration, only: %i[new create]
  resources :passwords, param: :token

  get "up" => "rails/health#show", :as => :rails_health_check

  root "pages#home"

  resources :users, only: :show do
    member do
      get :edit_avatar
      patch :update_avatar
    end
  end

  resources :playlists, only: %i[new create show]
end
