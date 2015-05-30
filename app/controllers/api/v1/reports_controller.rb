class Api::V1::ReportsController < ApplicationController
  def index
    @reports = Report.all
    render json: @reports
  end

  def create
    @report = Report.create report_params
    render json: @report
  end

  def update
    @report = Report.find params[:id]
    @report.update_attributes report_params
    render json: @report
  end

  def destroy
    Report.destroy params[:id]
  end

  private
  def report_params
    params.require(:report).permit(:pet_name, :animal_type, :lat, :lng,
                                   :user_id, :report_type, :notes, :img_url,
                                   :age, :breed, :sex, :size, :distance)
  end
end