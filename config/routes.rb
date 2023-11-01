Rails.application.routes.draw do
  devise_for :users, path: 'users', path_names: {
    sign_in: '/login',
    sign_out: '/logout',
    registration: '/signup'
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  get "/current-user", to: "users/users#show"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
