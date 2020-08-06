class SendEmailNotification
  attr_accessor :data

  def initialize(data)
    self.data = data
  end

  def perform
     NotificationFactory::Mailer.send(data)
  end

end
