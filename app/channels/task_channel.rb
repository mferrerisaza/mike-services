class TaskChannel < ApplicationCable::Channel
  def subscribed
    stream_from "task"
  end

  def unsubscribed
    stop_all_streams
  end

  def send_push_notification(data)
    Webpush.payload_send(
      message: data["message"],
      endpoint: data["subscription"]["endpoint"],
      p256dh: data["subscription"]["keys"]["p256dh"],
      auth: data["subscription"]["keys"]["auth"],
      vapid: {
        subject: "mailto:sender@example.com",
        public_key: ENV['VAPID_PUBLIC_KEY'],
        private_key: ENV['VAPID_PRIVATE_KEY']
      },
      ssl_timeout: 5,
      open_timeout: 5,
      read_timeout: 5
    )
  end
end
