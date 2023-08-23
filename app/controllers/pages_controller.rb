class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @spaces = Space.all
    @spaces_s = @spaces.sort_by { |space| space.rating.to_i }.reverse
    @spaces_3s = @spaces_s.first(3)
  end

  def dashboard
    @spaces = current_user.spaces
    @bookings = current_user.bookings
  end

end
