Rails.application.routes.draw do
  concern :base_api do
    resources :shorteners, except: [:show]
  end

  namespace :v1 do
    concerns :base_api
    get "/:short_code", to: "shorteners#show", as: 'short_code'
  end
end
