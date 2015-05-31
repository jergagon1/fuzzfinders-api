class ReportsController < ApplicationController
  def create
    current_user(params[:email], params[:password_hash])
    if @current_user
      @report = Report.new report_params
      @report.user_id = @current_user["id"]
      @report.save
      render json: @report
    else
      render json: "invalid credentials", status: 401
    end
  end

  private
  def report_params
    params.require(:report).permit(:pet_name, :animal_type, :lat, :lng,
                                   :user_id, :report_type, :notes, :img_url,
                                   :age, :breed, :sex, :size, :distance)
  end
end