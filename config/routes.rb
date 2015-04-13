Rails.application.routes.draw do
  scope module: 'v1', defaults: { format: 'json'} do
    resources :sessions, only: :create
    resources :users, only: :create
  end
end
