class AnnouncementsController < ApplicationController
  def index
    render json: Announcement.all
  end

  def show
    render json: Announcement.find(params[:id])
  end
end
