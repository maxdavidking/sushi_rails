class DataController < ApplicationController
  before_action :set_datum, only: %i[show edit update destroy]

  # DELETE /data/1
  # DELETE /data/1.json
  def destroy
    @datum.destroy
    if @datum.destroyed?
      redirect_to user_index_path
      flash[:success] = "File was successfully deleted."
    else
      redirect_to user_index_path
      flash[:warning] = "Something went wrong - #{@datum} was not deleted."
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_datum
    @datum = Datum.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def datum_params
    params.require(:datum).permit(:date, :organization_id, :sushi_id, :file)
  end
end
