class ReportsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:mapquery]
  require 'pusher'

  def create
    @report = Report.new report_params
    @user = User.where(id: params[:report][:user_id]).first
    if @report.save
      # trigger a notification to Pusher service
      trigger_pusher_notification(@report)
      # update user wags if report_type is found pet
      if @report.report_type == "found"
        update_wags(@user)
      end
      render json: { :report => @report, :wags => @user.wags, :tags => @report.all_tags }
    else
      render json: { :errors => :report.errors.full_messages }
    end
  end

  def show
    @report = Report.find params[:report_id]
    @tags = @report.all_tags
    @comments = @report.comments
    render json: { :report => @report, :tags => @tags, :comments => @comments }
  end

  def update
    @report = Report.find params[:report_id]
    @report.update_attributes report_params
    render json: @report
  end

  def destroy
    @report = Report.find params[:report_id]
    render json: @report.destroy
  end

  def mapquery
    # Example map query:
    # http://localhost:3000/api/v1/reports/mapquery?sw=37.70186970040842,-122.16973099925843&ne=37.70764178721548,-122.15589080074159
    swa = params[:sw].split(',').map(&:to_f)
    nea = params[:ne].split(',').map(&:to_f)
    #Make the SW as a point instance in Geokit
    sw = Geokit::LatLng.new(swa.first, swa.last)
    #Make the NE as a point instance in Geokit
    ne = Geokit::LatLng.new(nea.first, nea.last)
    #Get all Report instances from the database
    @reports = Report.in_bounds([sw, ne]).reverse_order
    render json: @reports
  end

  private
  def report_params
    params.require(:report).permit(
      :pet_name,
      :animal_type,
      :lat,
      :lng,
      :user_id,
      :report_type,
      :notes,
      :img_url,
      :age,
      :breed,
      :sex,
      :size,
      :distance,
      :color,
      :last_seen,
      :all_tags,
      :report_username
    )
  end

  # def index
  #   @products = Product.where(nil)
  #   filtering_params(params).each do |key, value|
  #     @products = @products.public_send(key, value) if value.present?
  #   end
  # end



  # A list of the param names that can be used for filtering the Report list
  def filtering_params(params)
    params.slice(:report_type, :animal_type, :starts_with)
  end

  def trigger_pusher_notification report
    # trigger a notification to Pusher service
    pusher = Pusher::Client.new app_id: ENV['PUSHER_APP_ID'], key: ENV['PUSHER_KEY'], secret: ENV['PUSHER_SECRET']
    # handle edge case if no value is given for report.animal_type
    if report.animal_type != ""
      report_animal_type = report.animal_type.capitalize
    else
      report_animal_type = "Pet"
    end
    # trigger on channel 'fuzzflash' an event called 'report_created' with this payload:
    pusher.trigger(
      'fuzzflash',
      'report_created',
      { :message => "Fuzzflash: #{report.report_type.capitalize} #{report_animal_type}" }
    )
  end

  def update_wags user
    # update user wags
    user.wags += 1
    user.save
  end

end
