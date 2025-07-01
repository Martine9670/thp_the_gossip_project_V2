class User < ApplicationRecord
  belongs_to :city

  has_many :gossips

  has_many :sent_messages, class_name: "Message", foreign_key: "sender_id"

  has_many :message_recipients

  has_many :received_messages, through: :message_recipients, source: :message

  has_many :comments

  has_many :likes
end
