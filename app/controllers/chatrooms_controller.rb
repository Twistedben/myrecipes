class ChatroomsController < ApplicationController
#Prevents users from access "/chat" 
  before_action :require_user
  
  def show
    @message = Message.new
#Below, we have to display existing messages in the DB
    @messages = Message.most_recent
  end
  
end