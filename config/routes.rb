Rails.application.routes.draw do
  get 'switch_language/:locale', to: 'application#switch_language', as: :switch_language

  get 'home/index'
  root 'home#index'
end
