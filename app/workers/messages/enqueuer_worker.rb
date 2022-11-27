module Messages
  class EnqueuerWorker
    include Sidekiq::Worker

    def perform
      request_count = rand(1..5)
      request_count.times do
        SendingMessageWorker.perform_async
      end
    end
  end
end
