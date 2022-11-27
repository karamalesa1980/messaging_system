require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  resources :message_receivers, only: [] do
    collection do
      post :process_message
    end
  end
end
