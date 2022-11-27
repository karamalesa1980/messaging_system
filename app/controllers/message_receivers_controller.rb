class MessageReceiversController < ApplicationController
  skip_before_action :verify_authenticity_token

  def process_message
    render status: 200, json: {}
  end
end
