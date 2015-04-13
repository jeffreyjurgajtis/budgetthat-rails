Rails.application.routes.draw do
  scope module: 'v1', defaults: { format: 'json'} do
    resources :sessions, only: :create
  end
end
