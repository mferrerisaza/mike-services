class PlayerChannel < ApplicationCable::Channel
  def subscribed
    stream_from "player"
  end

  def unsubscribed
    stop_all_streams
  end
end
