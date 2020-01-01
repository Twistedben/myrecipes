class MessagesController < ApplicationController
  before_action :require_user #Dependent on users being logged in for action to occur.

  def create
    @message = Message.new(message_params)
    @message.chef = current_chef #Supplied by the "before_action"
    if @message.save
#Below, we add the code for ActionCable to broadcast our form submissions from the "show.thml.erb" file. 
#We also use a new method defined in Private that renders the "_message" partial, which can be used for chat
      ActionCable.server.broadcast 'chatroom_channel', message: render_message(@message),
                                                        chef: @message.chef.chefname
    else 
      render 'chatrooms/show'
    end 
  end
  
  private
  
  def message_params
    params.require(:message).permit(:content) 
  end 
  
  def render_message(message)
#In the "message" partial, we use the object "message" and locals allows us to access that non-instance var
    render(partial: 'message', locals: { message: message })
  end
  
end