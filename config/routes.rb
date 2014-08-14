BonzTest::Application.routes.draw do
  resources :users

  match '/register', to: 'users#new'

	 resources :blogs do
 		 get :feed, on: :member
 		 resources :blog_posts do
      collection do
        post :create_asset
        get :pending
      end

      member do
        get :close
      end
  		end
 	end

	 resources :blog_categories
	 resources :blog_assets
	 resources :blog_comments do
 		 get :approve, on: :member
    post :feature, on: :member
    post :approval_decision, on: :member
 	end

	 match '/blog/:blog_url_id_or_id', to: 'blog_posts#index'
	 match '/blog/:blog_url_id_or_id/:id', to: 'blog_posts#show'
	 match '/blog', to: 'blog_posts#index', blog_url_id_or_id: 'main'

  get '/login', to: 'sessions#new', as: :login
  post '/login', to: 'sessions#create', as: :login
  get '/logout', to: 'sessions#destroy', as: :logout

  root to: 'blogs#index'
end
