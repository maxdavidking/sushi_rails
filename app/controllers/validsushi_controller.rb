class ValidsushiController < ApplicationController
  def index
    @validsushi = Validsushi.all
  end
end
