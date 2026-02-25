class Message < ApplicationRecord
  belongs_to :chat
  validates :content, length: { minimum: 6 }
end
