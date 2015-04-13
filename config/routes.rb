Rails.application.routes.draw do
  scope module: 'v1', defaults: { format: 'json'} do
    resources :budget_sheets, only: [:index, :create, :show, :destroy] do
      resources :categories, shallow: true, except: [:new, :edit, :show]
    end
    resources :sessions, only: :create
    resources :users, only: :create
  end
end
