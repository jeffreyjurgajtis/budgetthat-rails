Rails.application.routes.draw do
  scope module: 'v1', defaults: { format: 'json'} do
    resources :budget_sheets, only: [:index, :create, :show, :destroy]
    resources :sessions, only: :create
    resources :users, only: :create
  end
end
