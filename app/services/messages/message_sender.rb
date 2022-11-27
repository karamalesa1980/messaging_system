module Messages
  class MessageSender
    include HTTParty

    def initialize
      @message = create_message
    end

    def call
      activity_simulation
      response = HTTParty.post(Rails.application.secrets.request_url)
      status = response.success? ? 'completed' : 'has_error'
      update_message_status(status)
    rescue HTTParty::Error, StandardError => e
      handle_error(e)
    end

    private

    def activity_simulation
      sleep 5
    end

    def handle_error(error)
      Rails.logger.error(error)
      update_message_status('has_error')
    end

    def update_message_status(status)
      @message.update_column(:status, status)
    end

    def create_message
      Message.create(status: 'created')
    end
  end
end
