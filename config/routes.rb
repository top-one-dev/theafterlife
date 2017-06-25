Rails.application.routes.draw do
  devise_for :members, :controllers => { :omniauth_callbacks => "members/omniauth_callbacks" }

  namespace :members do
    root 'dashboards#index'
  end
end
