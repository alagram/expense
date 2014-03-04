Expense::Application.routes.draw do

  resources :items, only: [:new, :create] do
    collection do
      get 'search', to: 'items#search'
    end
  end

  get 'ui(/:action)', controller: 'ui'
  root to: 'items#index'

  get 'find', to: 'items#find'
  get 'sign_in', to: 'sessions#new'
  get 'register', to: 'users#new'
end
