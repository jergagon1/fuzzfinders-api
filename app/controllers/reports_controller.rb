class ReportsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:mapquery]
  require 'pusher'
    
  def create
    p 'Params::'
    p params
    @report = Report.new report_params
    @report.user_id = session[:user_id]
      p @report.report_type 
      type = @report.report_type

    if @report.save 
      pusher = Pusher::Client.new app_id: '130524', key: '3b5fcae47e2c2ecfad91', secret: '11ba4223aaf0d55bc501'
      # trigger on my_channel' an event called 'my_event' with this payload:
      pusher.trigger('fuzzflash', 'report_created', {
          :message => "Fuzzflash: #{@report.report_type} #{@report.animal_type}"

      })
      render json: @report
    else
      puts 'report not saved'
    end
  end

  def mapquery
    #Example map query http://localhost:3001/api/v1/reports/mapquery?sw=37.70186970040842,-122.16973099925843&ne=37.70764178721548,-122.15589080074159
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
