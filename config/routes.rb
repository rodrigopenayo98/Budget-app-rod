Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  unauthenticated do
    root 'splash_screen#index', as: :unauthenticated_root
  end

  authenticated :user do
    root 'categories#index', as: :authenticated_root
  end

  resources :categories do
    resources :payments
  end
end
