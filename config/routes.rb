Rails.application.routes.draw do
  root 'urls#index'

  resources :urls, only: [:create, :show]

  get '/:short_url', to: 'urls#redirect', as: :go_to_url

  namespace :api do
    namespace :v1 do
      resources :urls, only: [:index]
    end
  end

  post 'urls/:id/visit', to: 'urls#visit', as: 'url_visit'
end
