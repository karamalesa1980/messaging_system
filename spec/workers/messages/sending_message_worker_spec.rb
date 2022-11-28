require 'rails_helper'
require 'support/spec_utils'

RSpec.describe Messages::SendingMessageWorker, type: :worker do
  def method_call
    described_class.perform_async
  end

  it 'calls message sender service' do
    Sidekiq::Testing.inline! do
      enqueuer_class, enqueuer_instance = stub_service(klass: Messages::MessageSender)

      method_call

      expect(enqueuer_class).to have_received(:new)
      expect(enqueuer_instance).to have_received(:call)
    end
  end
end
