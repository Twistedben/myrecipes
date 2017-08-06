class ChatroomsController < ApplicationController
  
  def show
    @message = Message.new
#Below, we have to display existing messages in the DB
    @messages = Message.most_recent
  end
  
end