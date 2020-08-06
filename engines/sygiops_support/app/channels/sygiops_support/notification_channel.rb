module SygiopsSupport
  class NotificationChannel < ApplicationCable::Channel
    def subscribed
      # stop_all_streams
      puts "$$$$$$$$$$$$$$$$$$$$$subscribed$$$$$$$$$$$$$$$$$$$$$$$$$$"
      stream_from "notification_channel"
      # ActionCable.server.broadcast("notification_channel", "Hello World")
    end

    def unsubscribed
      puts "$$$$$$$$$$$$$$$$$$$$$unsubscribed$$$$$$$$$$$$$$$$$$$$$$$$$$"
      # stop_all_streams
      # Any cleanup needed when channel is unsubscribed
    end
  end
end
