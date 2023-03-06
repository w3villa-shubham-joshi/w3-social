Rails.application.routes.draw do
  resources :messages
  # get 'rooms/index'

  devise_for :users
 

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

  resources :rooms
  resources :users

end
