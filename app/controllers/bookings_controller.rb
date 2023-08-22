class BookingsController < ApplicationController
  def index
  end

  def show
  end

  def edit
  end

  def new
    @booking = Booking.new
  end

  private

  def booking_params
    params.require(:booking).permit()
  end
end
