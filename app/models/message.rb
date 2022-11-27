class Message < ApplicationRecord
  extend Enumerize

  enumerize(:status, in: %i[created completed has_error])
end
