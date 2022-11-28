require 'rails_helper'
require 'support/spec_utils'

RSpec.describe Messages::EnqueuerWorker, type: :worker do
  def method_call
    described_class.perform_async
  end

  it 'calls sending message worker' do
    Sidekiq::Testing.inline! do
      allow(Rails.application.secrets).to receive(:request_count).and_return(2)
      receiver_worker = stub_worker(klass: Messages::SendingMessageWorker)

      method_call

      expect(receiver_worker).to have_received(:perform_async).twice
    end
  end
end
