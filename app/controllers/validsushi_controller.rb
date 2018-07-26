class ValidsushiController < ApplicationController
  def new
    # Does not correspond to a route - only used for importing data
    # to Sushi.new on click in the view sushi/_validsushi.new.html.erb
    @validsushi = Validsushi.find(params[:id])
    @sushi = Sushi.new
    head :ok
  end
end
