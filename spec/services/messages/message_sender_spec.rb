require 'rails_helper'

RSpec.describe Messages::MessageSender, type: :service do
  describe '#call' do
    def method_call
      described_class.new.call
    end

    context 'when the message was sent without error' do
      it 'creates a message with completed status' do
        allow(Rails.application.secrets).to receive(:request_url).and_return('http://example.com')
        stub_request(:post, 'http://example.com').to_return(status: 200)

        method_call

        message = Message.last
        expect(message.status).to eq('completed')
      end
    end

    context 'when the message was sent with an error' do
      it 'creates a message with has_error status' do
        allow(Rails.application.secrets).to receive(:request_url).and_return('http://example.com')
        stub_request(:post, 'http://example.com').to_return(status: 404)

        method_call

        message = Message.last
        expect(message.status).to eq('has_error')
      end
    end
  end
end
