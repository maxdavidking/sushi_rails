class SushiChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'sushi'
  end
end
