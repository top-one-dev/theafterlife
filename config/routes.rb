Rails.application.routes.draw do
  root 'pages#index'
  devise_for :members, :controllers => { :omniauth_callbacks => "members/omniauth_callbacks", :registrations => 'members/registrations' }

  get 'health' => 'pages#health'

  namespace :members do
    root 'dashboards#index'
  end
end
