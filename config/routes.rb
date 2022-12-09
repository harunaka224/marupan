Rails.application.routes.draw do

  devise_for :admin,  skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
}

  namespace :admin do
    root :to => "homes#top"
    resources :end_users, only: [:show, :edit, :update]  
  end
  
  devise_for :end_users, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: "public/sessions"
}
  
  scope module: :public do
    root :to => "homes#top"
    resources :posts, only: [:index, :show]
    resources :end_users, only: [:edit, :update, :quit, :out]
    resources :post_comments, only: [:create, :destroy]
    resources :likes, only: [:index, :create, :destroy]
    resources :relationships, only: [:create, :destroy]
    get "/notifications" => "notifications#index"
    get "/search" => "searches#/search"
    
  end
# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
