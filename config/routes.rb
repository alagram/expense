Expense::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'
  root to: 'items#index'

  resources :items, only: [:new, :create] do
    collection do
      get 'search', to: 'items#search'
    end
  end

  get 'find', to: 'items#find'
end
