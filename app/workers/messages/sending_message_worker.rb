require 'httparty'

module Messages
  class SendingMessageWorker
    include Sidekiq::Worker
    include Sidekiq::Throttled::Worker

    sidekiq_throttle(
      threshold: {
        limit: 100,
        period: 1.hour
      }
    )

    def perform
      MessageSender.new.call
    end
  end
end
