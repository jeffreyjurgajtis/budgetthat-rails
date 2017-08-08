Rails.application.routes.draw do
  scope module: 'v1', defaults: { format: 'json'} do
    resources :budget_sheets, except: [:new, :edit] do
      resources :categories, only: :index
      get "entries", to: "entries#index"
      post "entries/import", to: "entries/imports#create"
    end
    resources :categories, only: [:create, :show, :update, :destroy]
    resources :entries, only: [:create, :update, :destroy]
    resources :sessions, only: :create
    resources :users, only: :create
  end
end
