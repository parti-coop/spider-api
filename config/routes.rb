Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'page', to: 'pages#show'
    end
  end
end
