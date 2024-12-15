Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    get "switch_language/:locale", to: "application#switch_language", as: :switch_language
    resources :jobs
    resources :companies
    resources :users do
      resources :user_profiles do
        member do
          delete :remove_skill
          post :add_skill
        end
      end
      resources :user_projects
      resources :user_social_links
    end
    resources :applications, only: %i(create show update)
    get "home/index"
    root "home#index"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
  end
end
