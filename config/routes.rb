Rails.application.routes.draw do
  root 'urls#index'

  resources :urls, only: [:create, :show]

  get '/:short_url', to: 'urls#redirect', as: :go_to_url
  get '/top', to: 'urls#top', as: :top_urls

  post 'urls/:id/visit', to: 'urls#visit', as: 'url_visit'
end