class ValidsushiController < ApplicationController
  def new
    # Autopopulates validsushi data into a Sushi.new form
    @validsushi = Validsushi.find(params[:id])
    @sushi = Sushi.new
  end
end
