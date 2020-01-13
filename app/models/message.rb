class Message < ApplicationRecord
  include RecentMessages
#Message belongs to Chef so Chef has Many Messages
#   belongs_to :chef
#   validates :content, presence: true 
#   validates :chef_id, presence: true

# #Below we create a method that shows/orders the last 20 messages in the chatroom
#   def self.most_recent
#     order(:created_at).last(20)
#   end
  
end