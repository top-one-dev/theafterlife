Rails.application.routes.draw do
  devise_for :members

  namespace :members do
    root 'dashboards#index'
  end
end
