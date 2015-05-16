Rails.application.routes.draw do
  scope module: 'v1', defaults: { format: 'json'} do
    resources :budget_sheets, except: [:new, :edit]
    resources :categories, only: [:create, :update, :destroy]
    resources :entries, only: [:create, :update, :destroy]
    resources :sessions, only: :create
    resources :users, only: :create
  end
end
