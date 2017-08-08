App.chatroom = App.cable.subscriptions.create "ChatroomChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) -> #Here we need the Event Listener, wich is the ID "messages" inside "show.html.erb"
    $('#messages').append data['message'] #'data' here is what we're passing in to display
    $('#message_content').val '' #This is from "_message" partial, the div class and span class together
    scrollToBottom() #Here, we scroll the chatbox to the bottom, most recent messages when window is loaded
    return  
    
    scrollToBottom = ->
      if $('#messages').length > 0
        last_message = $('#messages')[0]
        last_message.scrollTop = last_message.scrollHeight - (last_message.clientHeight)
      return 
    
    jQuery(document).on 'turbolinks:load', ->
      scrollToBottom()
      return
    # Called when there's incoming data on the websocket for this channel
