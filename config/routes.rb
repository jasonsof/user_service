Rails.application.routes.draw do
  resources :sessions, only: [:create]
  get 'lobby', action: :show, controller: 'lobby'
end
