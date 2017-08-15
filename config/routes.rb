Rails.application.routes.draw do
  root 'pages#index'
  devise_for :members, :controllers => { :omniauth_callbacks => "members/omniauth_callbacks", :registrations => "members/registrations", :confirmations => "members/confirmations" }

  mount DryAdmin::Engine => '/admin'

  get 'health' => 'pages#health'

  namespace :members do
    root :to => redirect('members/last_wishes/relationships')

    namespace :last_wishes do
      root :to => redirect('members/last_wishes/relationships')
      get 'relationships' => 'dashboards#relationships'
      get 'body' => 'dashboards#body'
      get 'possession' => 'dashboards#possessions', :as => 'my_possessions'
      get 'funeral' => 'dashboards#funeral'
      get 'story' => 'dashboards#story'
      get 'files' => 'dashboards#files'
      get 'my_sensitive_info' => 'dashboards#sensitive_info'

      resources :people
      resources :pets
      resources :possessions
      resource :memorial_marker
      resource :memorial_contribution
      resources :member_files
      resources :letters
      resources :musics do
        get :play
      end
      resources :writings
      resources :memories
      resources :photos
      resources :questionnaires
      resources :sensitive_infos do
        get  'unlock' => 'sensitive_infos#unlock'
        post 'unlock' => 'sensitive_infos#confirm_unlock'
      end

      resource :science_donation, :only => [:show, :update]
      resource :cremation, :only => [:show, :update]
      resource :burial_service, :only => [:show, :update]
      resource :funeral_service, :only => [:show, :edit, :update]
      resource :reception, :only => [:show, :edit, :update]
      resource :headstone, :only => [:show, :edit, :update]
      resource :program, :only => [:show, :edit, :update]
      resource :transportation, :only => [:show, :edit, :update]
      resource :visitation, :only => [:show, :edit, :update]
      resource :obituary, :only => [:show, :edit, :update]
    end

    namespace :save do
      resources :deposits, :except => [:edit, :update] do 
        post 'pay_stripe'
        get 'pay_coinbase'
      end
      resources :plans, :only => [:new, :create] do
        get 'cancel'
        post 'pay_stripe'
        get 'pay_coinbase'
      end
    end
  end

  resources :webhooks do
    collection do
      post 'stripe' => 'webhooks#stripe'
    end
  end
end