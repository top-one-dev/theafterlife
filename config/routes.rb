Rails.application.routes.draw do
  devise_for :members, :controllers => { :omniauth_callbacks => "members/omniauth_callbacks" }

  get 'health' => 'pages#health'

  namespace :members do
    root 'dashboards#index'
  end
end
