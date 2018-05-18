class ValidsushiController < ApplicationController
  def new
    @validsushi = Validsushi.find(params[:id])
    @sushi = Sushi.new
  end
end
