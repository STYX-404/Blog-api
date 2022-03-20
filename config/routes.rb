Rails.application.routes.draw do
  namespace 'api' do 
    namespace 'v1' do
      resources :users
      post "/login", to:"users#login"
      get "/auto_login", to:"users#auto_login"
      post "posts", to:"posts#create"
      get "posts", to:"posts#index"
      get "posts/:id", to:"posts#show"
      put "posts/:id", to:"posts#update"
      delete "posts/:id", to:"posts#destroy"
      post "posts/:id/comments", to:"comments#create"
      get "posts/:id/comments", to:"comments#index"
      get "posts/:id/comments/:id", to:"comments#show"
      put "posts/:id/comments/:id", to:"comments#update"
      delete "posts/:id/comments/:id", to:"comments#destroy"
      put "posts/:id_post/tags/:id_tag", to:"tags#update"

    end
  end
end
