class NotifyFrontend

  def perform
    ActionCable.server.broadcast(
      "notification_channel",
      msg: "new ticket is created"
    )
  end

end
