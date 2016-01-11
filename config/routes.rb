Rails.application.routes.draw do
  root to: redirect('http://parti.xyz/')
  namespace :api do
    namespace :v1 do
      get 'page', to: 'pages#show'
    end
  end
end
