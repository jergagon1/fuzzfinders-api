
class ReportsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:mapquery]
  require 'pusher'

  def status
    render json: { value: "jeremy", user_count: User.all.count }
  end

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
      render json: { :report => @report, :wags => @user.wags, :tags => @report.tag_list }
    else
      render json: { :errors => :report.errors.full_messages }
    end
  end

  def show
    @report = Report.find params[:report_id]
    @tags = @report.tags
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
    swa = params[:sw].split(',').map(&:to_f)
    nea = params[:ne].split(',').map(&:to_f)
    # Make the SW as a point instance in Geokit
    sw = Geokit::LatLng.new(swa.first, swa.last)
    # Make the NE as a point instance in Geokit
    ne = Geokit::LatLng.new(nea.first, nea.last)
    if params[:filter_tags] != ""
      # Filter reports per Filterable module
      # Use Geokit in_bounds method to get report instances within map extents
      # Filter by tags in parameters
      @reports = Report.filter(params.slice(:report_type, :animal_type, :sex, :pet_size, :age, :breed, :color)).in_bounds([sw, ne]).tagged_with(params[:filter_tags], :any => true)
    else
      # Filter reports per Filterable module
      # Use Geokit in_bounds method to get report instances within map extents
      @reports = Report.filter(params.slice(:report_type, :animal_type, :sex, :pet_size, :age, :breed, :color)).in_bounds([sw, ne])
    end
    render json: @reports.reverse_order
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
      :pet_size,
      :distance,
      :color,
      :last_seen,
      :tag_list,
      :report_username
    )
  end

  # trigger pusher notification on report creation
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
      {
        message: "Fuzzflash: #{report.report_type.capitalize} #{report_animal_type}",
        report_id: report.id,
        report_type: report.report_type,
        latitude: report.lat,
        longitude: report.lng
      }
    )
  end

  # Update the users wags if make found pet report
  def update_wags user
    # update user wags
    user.wags += 1
    user.save
  end

end
