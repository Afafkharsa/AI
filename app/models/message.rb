class Message < ApplicationRecord
  MAX_USER_MESSAGES = 10

  belongs_to :chat

  validate :user_message_limit, if: -> { role=="user" }

  private

  def user_message_limit
    if chat.messages.where(role= "user").count >= Message::MAX_USER_MESSAGES
      errors.add(:content, "You can only send #{Message::MAX_USER_MESSAGES} messages per chat")
    end

  end

end
