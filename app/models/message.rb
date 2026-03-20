class Message < ApplicationRecord
  belongs_to :chat
  MAX_USER_MESSAGES = 10
end
