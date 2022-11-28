require 'rails_helper'

RSpec.describe MessageReceiversController, type: :controller do
  describe 'GET #process_message' do
    it 'responds with 200' do
      process :process_message, method: :post, params: {}, xhr: true

      expect(response).to have_http_status(:ok)
    end
  end
end
