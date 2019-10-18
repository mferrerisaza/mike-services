class TaskChannel < ApplicationCable::Channel
  def subscribed
    stream_from "task"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
