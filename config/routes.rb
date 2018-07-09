Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :users, :only => :show
  resources :posts
  get '/posts/:id/qrcode', to: 'posts#qrcode', as: 'post_qrcode'
  root 'posts#index'  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
