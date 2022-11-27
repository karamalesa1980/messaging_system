module Messages
  class EnqueuerWorker
    include Sidekiq::Worker

    def perform
      request_count = Rails.application.secrets.request_count
      request_count.times do
        SendingMessageWorker.perform_async
      end
    end
  end
end
