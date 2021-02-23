Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

get '/posts/:id', to:'posts#show'

get '/posts', to: 'posts#index'

post '/posts', to: 'posts#create'

delete '/posts/:id', to: 'posts#delete'

put '/posts/:id', to: 'posts#update'

end
