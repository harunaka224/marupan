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
  #ゲストユーザー機能
  devise_scope :end_user do
    post 'guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  scope module: :public do
    root :to => "homes#top"
    #退会機能
    get '/end_users/quit' => 'end_users#quit'
    patch '/end_users/out' => 'end_users#out'
    resources :end_users, only: [:show, :edit, :update, :quit, :out]
    resources :posts do
     resource :likes, only: [:create, :destroy]
    end
    resources :post_comments, only: [:create, :destroy]
    resources :relationships, only: [:create, :destroy]
    get "/notifications" => "notifications#index"
    get "/search" => "searches#search"

  end
# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
