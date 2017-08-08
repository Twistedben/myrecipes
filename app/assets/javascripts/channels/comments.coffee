App.comments = App.cable.subscriptions.create "CommentsChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
#Below, we simply say, every time we have a new comment in "#messages" put its data ontop
    $("#messages .comment-fix:first").prepend(data)
    # Called when there's incoming data on the websocket for this channel
