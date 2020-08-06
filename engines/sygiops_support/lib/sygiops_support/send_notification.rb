class SendNotification
  attr_accessor :data

  def initialize(data)
    self.data = data
  end

  def perform
     ActionCable.server.broadcast("notification_channel",data: data)
  end

end
