class BookingsController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def show
    @space = Space.find(params[:space_id])

  end

  def edit
  end

  def create
    @space = Space.find(params[:space_id])
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @booking.space = @space
    @booking.save!
    redirect_to spaces_path
  end

  private

  def booking_params
    params.require(:booking).permit(:space_id, :booking_start_date, :booking_end_date)
  end
end
