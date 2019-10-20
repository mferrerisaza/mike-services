class TaskChannel < ApplicationCable::Channel
  def subscribed
    stream_from "task"
  end

  def unsubscribed
    stop_all_streams
  end
end
