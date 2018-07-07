Rails.application.routes.draw do
  resources :posts
  get '/posts/:id/qrcode', to: 'posts#qrcode', as: 'post_qrcode'
  root 'posts#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
