class ImagesController < ApplicationController
  def create
    @image = Image.new(user: current_user)
    @image.image = params[:image]
    @image.save!

    render json: @image
  end
end
