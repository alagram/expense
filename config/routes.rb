Expense::Application.routes.draw do

  get 'ui(/:action)', controller: 'ui'
  root to: 'pages#front'

  get 'register', to: 'users#new'
  get 'home', to: 'items#index'
  get 'find', to: 'items#find'
  get 'sign_in', to: 'sessions#new'
  get 'sign_out', to: 'sessions#destroy'
  get 'new_list', to: 'lists#new'

  resources :items, only: [:new, :create] do
    collection do
      get 'search', to: 'items#search'
    end
  end

  resources :users, only: [:create]
  resources :sessions, only:[:create]
  resources :lists, only:[:create, :show] do
    resources :list_items, only:[:create]
  end

end
