class ReportsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:mapquery]
  require 'pusher'

  def create
    @report = Report.new report_params
    @user = User.where(id: params[:report][:user_id]).first
    if @report.save
      # trigger a notification to Pusher service
      pusher = Pusher::Client.new app_id: ENV['PUSHER_APP_ID'], key: ENV['PUSHER_KEY'], secret: ENV['PUSHER_SECRET']
      # trigger on channel 'fuzzflash' an event called 'report_created' with this payload:
      pusher.trigger('fuzzflash', 'report_created', {
        :message => "Fuzzflash: #{@report.report_type} #{@report.animal_type}"
      })
      # update user wags if report_type is found pet
      if @report.report_type == 'found'
        @user.wags += 1
        @user.save
      end
      render json: { :report => @report, :wags => @user.wags, :tags => @report.all_tags }
    else
      render json: { :errors => :report.errors.full_messages }
    end
  end

  def mapquery
    #Example map query http://localhost:3000/api/v1/reports/mapquery?sw=37.70186970040842,-122.16973099925843&ne=37.70764178721548,-122.15589080074159
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
                                   :age, :breed, :sex, :size, :distance, :color, :all_tags)
  end
end
