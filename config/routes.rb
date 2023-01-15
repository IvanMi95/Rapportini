Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: "users/registrations" 
  }  
  root   'static_pages#home'
  resources :users 
  resources :clients do
    member do
      get 'new_report'
      post 'create_new_report', to: 'reports#create'
    end
    # resources :reports, only: [ :new, :create]
  end
  resources :reports, only: [:index, :show, :edit, :update, :destroy]

  

  # post 'reports', to: 'report#create'
end
