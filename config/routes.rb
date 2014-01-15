Expense::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'
  root to: 'expenses#dashboard'

end
