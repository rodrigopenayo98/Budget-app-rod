Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  authenticated :user do
    root 'categories#index', as: :authenticated_root
  end

  unauthenticated do
    root 'users#index'
  end

  resources :categories do
    resources :transactions
  end
end
