class SushiController < ApplicationController
  def index
    @sushi = Sushi.all
  end
end
