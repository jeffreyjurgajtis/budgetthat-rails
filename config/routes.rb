Rails.application.routes.draw do
  scope module: 'v1', defaults: { format: 'json'} do
    resources :budget_sheets, except: [:new, :edit] do
      resources :categories, shallow: true, except: [:new, :edit, :show] do
        resources :entries, shallow: true, only: [:create, :update, :destroy]
      end
    end

    resources :categories, except: [:index, :new, :edit, :show]

    resources :sessions, only: :create
    resources :users, only: :create
  end
end
