Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :challenges, only: [:index, :show, :destroy] do
    resources :chats, only: [:index, :create]
  end

  resources :chats, only: :show do
    resources :messages, only: [:create]
  end
end
