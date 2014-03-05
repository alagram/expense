Expense::Application.routes.draw do

  resources :items, only: [:new, :create] do
    collection do
      get 'search', to: 'items#search'
    end
  end

  resources :users, only: [:create]
  resources :sessions, only:[:create]

  get 'ui(/:action)', controller: 'ui'
  # root to: 'items#index'

  get 'find', to: 'items#find'
  get 'sign_in', to: 'sessions#new'
  get 'register', to: 'users#new'
  get 'home', to: 'items#index'
end
