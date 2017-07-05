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
      get 'possessions' => 'dashboards#possessions'
      get 'funeral' => 'dashboards#funeral'
      get 'story' => 'dashboards#story'
      get 'files' => 'dashboards#files'
      get 'sensitive_info' => 'dashboards#sensitive_info'

      resources :people
      resources :pets
      resources :possessions
      resources :memorial_markers
      resources :memorial_contribution
      resources :member_files
      resources :letters
      resources :musics
      resources :writings
      resources :memories
      resources :photos
      resources :questionnaires
      resources :sensitive_infos

      resource :science_donation, :only => [:show, :edit, :update]
      resource :cremation, :only => [:show, :edit, :update]
      resource :burial_service, :only => [:show, :edit, :update]
      resource :funeral_service, :only => [:show, :edit, :update]
      resource :reception, :only => [:show, :edit, :update]
      resource :headstone, :only => [:show, :edit, :update]
      resource :program, :only => [:show, :edit, :update]
      resource :transportation, :only => [:show, :edit, :update]
      resource :visitation, :only => [:show, :edit, :update]
      resource :obituary, :only => [:show, :edit, :update]
    end
  end
end
