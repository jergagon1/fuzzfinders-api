class ReportsController < ApplicationController
  # before_filter :cors_preflight_check
  # after_filter :cors_set_access_control_headers

  # def cors_set_access_control_headers
  #   headers['Access-Control-Request-Method'] = '*'
  #   headers['Access-Control-Allow-Origin'] = '*'
  #   headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
  #   headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, Accept, Authorization, Token'
  #   headers['Access-Control-Max-Age'] = '1728000'
  # end

  # def cors_preflight_check
  #   if request.method == 'OPTIONS'
  #     headers['Access-Control-Allow-Origin'] = '*'
  #     headers['Access-Control-Request-Method'] = '*'

  #     headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
  #     headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version, Token'
  #     headers['Access-Control-Max-Age'] = '1728000'

  #     render :text => '', :content_type => 'text/plain'
  #   end
    
  def create
    @report = Report.new report_params
    @report.user_id = @current_user["id"]
    @report.save
    render json: @report
  end

  def mapquery
    #Example map query http://localhost:3001/reports/mapquery?sw=37.70186970040842,-122.16973099925843&ne=37.70764178721548,-122.15589080074159
    swa = params[:sw].split(',').map(&:to_f)
    nea = params[:ne].split(',').map(&:to_f)
    sw = Geokit::LatLng.new(swa.first, swa.last)  #Make the SW as a point instance in Geokit
    ne = Geokit::LatLng.new(nea.first, nea.last)  #Make the NE as a point instance in Geokit
    render json: Report.in_bounds([sw, ne]) #Get all Report instances from the database
  end

  private
  def report_params
    params.require(:report).permit(:pet_name, :animal_type, :lat, :lng,
                                   :user_id, :report_type, :notes, :img_url,
                                   :age, :breed, :sex, :size, :distance)
  end
end
