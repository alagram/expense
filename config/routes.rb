Expense::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'
  root to: 'items#index'

  resources :items, only: [:new, :create]

  get 'find', to: 'items#find'
end
