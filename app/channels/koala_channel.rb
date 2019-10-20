class KoalaChannel < ApplicationCable::Channel
  def subscribed
    stream_from "koala_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def prueba
    puts "it worked"
  end
end
