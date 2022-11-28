require 'rails_helper'

RSpec.describe Message, type: :model do
  describe 'enumerizers' do
    it { is_expected.to enumerize(:status).in(:created, :completed, :has_error) }
  end
end
