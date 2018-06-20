class SushiChannel < ApplicationCable::Channel
  def subscribed
    stream_from "sushi_channel"
  end
end
