class AboutController < ApplicationController
  def index
  end

  def error_404
    render status: 404
  end
end
