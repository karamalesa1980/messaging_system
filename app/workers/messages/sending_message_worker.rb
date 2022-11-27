require 'httparty'

module Messages
  class SendingMessageWorker
    include Sidekiq::Worker
    include Sidekiq::Throttled::Worker

    sidekiq_throttle(
      threshold: {
        limit: 100,
        period: Rails.application.secrets.interval_of_request.second
      }
    )

    def perform
      MessageSender.new.call
    end
  end
end
