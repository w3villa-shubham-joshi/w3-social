Rails.application.routes.draw do
  # resources :messages

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }    
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
  # root 'rooms#index'
  resources :rooms do
    resources :messages
  end
  

end
