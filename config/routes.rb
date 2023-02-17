Rails.application.routes.draw do
  # devise_for :users, controllers: {
  #   sessions: 'users/sessions'
  # }
  # devise_for :users
  # root to: "devise/sessions#new" 
  # devise_scope :user do
    # get "/" => "devise/sessions#new"
  # end
  devise_for :users
  # devise_scope :user do
  # end

  root to: "home#index"
  resources :posts do
    put '/like', to: 'likes#like'
    put '/dislike', to: 'likes#dislike'
  end
  resources :comments
  resources :friend_requests, only: [:create] do 
    collection do
      post :accept
      post :reject
    end
  end 
  # resources :likes  do  
  # end
#  resources :home, only: :index
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
